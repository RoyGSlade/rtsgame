extends Node2D
var data := {}

func _ready():
	var building_id = name.to_lower()
	data = BuildingManager.get_building_data(building_id)

	if data.is_empty():
		push_error("Missing data for building: " + building_id)
		return

	# Placeholder: just show full texture
	$Sprite2D.texture = preload("res://Tiles/Tilesetbygpt.png")
