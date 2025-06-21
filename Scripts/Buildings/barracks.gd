extends "res://Scripts/building.gd"

@export var building_id: String = "barracks"

func _ready():
	data = BuildingManager.get_building_data(building_id)
	if data.is_empty():
		push_error("Missing data for building: " + building_id)
		return

	# Connect input events to receive clicks
	$Area2D.connect("input_event", Callable(self, "_on_input_event"))

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		show_unit_menu()

func show_unit_menu():
	var menu = preload("res://Scenes/UI/BarracksMenu.tscn").instantiate()
	menu.barracks = self
	get_tree().get_root().add_child(menu)
