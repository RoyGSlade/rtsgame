extends Node

var buildings = {}
var unemployed_citizens = []  # Pool of available worker nodes or IDs

func _ready():
	var file = FileAccess.open("res://Data/buildings.json", FileAccess.READ)
	if file:
		var parsed = JSON.parse_string(file.get_as_text())
		if typeof(parsed) == TYPE_ARRAY:
			for b in parsed:
				buildings[b["id"]] = b
		else:
			buildings = parsed
		file.close()
	else:
		push_error("Failed to load buildings.json")

# --- Resource Helpers (UNCHANGED) ---
func get_building_cost(building_id: String) -> Dictionary:
	var data = buildings.get(building_id)
	if data == null: return {}
	if data.has("cost"):
		return data["cost"]
	if data.has("upgrade") and data["upgrade"].has("1") and data["upgrade"]["1"].has("cost"):
		return data["upgrade"]["1"]["cost"]
	return {}

func can_afford(building_id: String) -> bool:
	return ResourceManager.has_resources(get_building_cost(building_id))

func pay_cost(building_id: String) -> void:
	ResourceManager.spend_resources(get_building_cost(building_id))

# --- Core Placement (UNCHANGED) ---
func spawn_building(building_id: String, pos: Vector2) -> Node2D:
	if not can_afford(building_id):
		print("Cannot afford:", building_id)
		return null

	var data = buildings.get(building_id)
	if data == null:
		push_error("Invalid building ID: " + building_id)
		return null

	var scene_path = data.get("scene_path", "")
	if scene_path == "":
		push_error("Missing 'scene_path' in buildings.json for: " + building_id)
		return null

	var building_scene = load(scene_path)
	if building_scene == null:
		push_error("Failed to load scene: " + scene_path)
		return null

	var building = building_scene.instantiate()
	building.position = pos.snapped(Vector2(32, 32))

	if "setup" in building:
		building.setup(data)
	else:
		print("Building scene missing setup():", building_id)

	# Add to scene
	get_tree().get_root().add_child(building)

	# Tag the building with its ID + optional save state
	building.set_meta("building_id", building_id)
	if "save_state" in building:
		building.set_meta("custom_data", building.save_state())

	# Store actual Node2D in placed_buildings
	placed_buildings.append(building)

	# Pay cost LAST (so you don't lose money if building fails)
	pay_cost(building_id)

	return building

# --- Info Access ---
func get_building_list() -> Array:
	return buildings.keys()

func get_building_data(id: String) -> Dictionary:
        return buildings.get(id, {})

# --- Save/Load Game State
var placed_buildings: Array = []
func save_placed_buildings() -> Array:
	var saved_data: Array = []

	for building in placed_buildings:
		var id = building.get_meta("building_id")
		var custom_data = {}

		if building.has_method("save_state"):
			custom_data = building.save_state()
		elif building.has_meta("custom_data"):
			custom_data = building.get_meta("custom_data")

		saved_data.append({
			"id": id,
			"position": {
				"x": building.position.x,
				"y": building.position.y
			},
			"rotation": building.rotation,
			"custom_data": custom_data
		})

	return saved_data

func load_placed_buildings(buildings_data: Array) -> void:
	# Clean up old buildings
	for child in get_tree().get_root().get_children():
		if child.has_meta("building_id"):
			child.queue_free()

	placed_buildings.clear()

	for b in buildings_data:
		var building_id = b.get("id", "")
		var pos_data = b.get("position", {})
		var position = Vector2(pos_data.get("x", 0), pos_data.get("y", 0))
		var rotation = b.get("rotation", 0.0)
		var custom_data = b.get("custom_data", {})

		var spawned = spawn_building(building_id, position)
		if spawned:
			spawned.rotation = rotation
			if "load_state" in spawned:
				spawned.load_state(custom_data)

		# Re-track
                placed_buildings.append(spawned)

# --- WORKER SYSTEM ---
func register_unemployed_citizen(worker) -> void:
        # Call this when a citizen is created or becomes unemployed
        unemployed_citizens.append(worker)

func request_workers(building: Node, count: int) -> void:
        var assigned = 0
        while assigned < count and unemployed_citizens.size() > 0:
                var worker = unemployed_citizens.pop_front()
                if is_instance_valid(worker):
                        building.assign_worker(worker)
                        assigned += 1
        if assigned < count:
                print("Not enough citizens for building:", building.name, "assigned:", assigned, "needed:", count)
        # Building will start when all slots are filled (handled in building.gd)

func return_worker(worker) -> void:
        # Called if building is destroyed or loses a worker
        unemployed_citizens.append(worker)
