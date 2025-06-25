extends "res://Scripts/building.gd"

func _ready():
	# Connect input events to receive clicks
	$Area2D.connect("input_event", Callable(self, "_on_input_event"))

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		show_unit_menu()

func show_unit_menu():
	var menu = preload("res://Scenes/UI/BarracksMenu.tscn").instantiate()
	menu.barracks = self
	get_tree().get_root().add_child(menu)
