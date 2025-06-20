extends Node

var buildings = {}
var building_scn = preload("res://Scenes/building.tscn")

func _ready():
	var file = FileAccess.open("res://Data/buildings.json", FileAccess.READ)
	if file:
		var parsed = JSON.parse_string(file.get_as_text())
		if typeof(parsed) == TYPE_ARRAY:
			for b in parsed:
				buildings[b["id"]] = b
		else:
			buildings = parsed # for dictionary format
		file.close()
	else:
		push_error("Failed to load buildings.json")

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

func spawn_building(building_id: String, pos: Vector2) -> Node2D:
	if not can_afford(building_id):
		print("Cannot afford " + building_id)
		return null

	var data = buildings.get(building_id)
	if data == null:
		push_error("Invalid building type: " + building_id)
		return null

	var building = building_scn.instantiate()
	building.setup(data)
	building.position = pos.snapped(Vector2(32, 32))
	pay_cost(building_id)
	get_tree().get_root().add_child(building)
	return building

func get_building_list() -> Array:
	return buildings.keys()
