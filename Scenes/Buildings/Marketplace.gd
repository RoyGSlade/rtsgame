extends "res://Scripts/building.gd"



func _ready():
	$Area2D/Sprite2D.texture = preload("res://Tiles/MarketPlace.png")
	data = BuildingManager.get_building_data(building_id)
	if data.is_empty():
		push_error("Missing data for building: " + building_id)
		return

	$Area2D.connect("input_event", Callable(self, "_on_input_event"))

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		show_storefront()

func show_storefront():
	var menu = preload("res://Scenes/UI/Storefront.tscn").instantiate()
	menu.store_building = self
	get_tree().get_root().add_child(menu)
