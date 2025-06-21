extends Node

var buildings = {}

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

# --- Resource Helpers ---
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

# --- Core Placement ---
func spawn_building(building_id: String, pos: Vector2) -> Node2D:
	if not can_afford(building_id):
		print("Cannot afford:", building_id)
		return null

	var data = buildings.get(building_id)
	if data == null:
		push_error( "Invalid building ID: " + building_id)
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

	pay_cost(building_id)
	get_tree().get_root().add_child(building)
	return building

# --- Info Access ---
func get_building_list() -> Array:
	return buildings.keys()

func get_building_data(id: String) -> Dictionary:
	return buildings.get(id, {})
