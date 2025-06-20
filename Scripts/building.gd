extends Node2D
@export var building_type := "Farm"
@export var cost_gold := 50
@export var cost_food := 10
@export var icon_texture : Texture2D
@export var sprite_region := Rect2(0, 0, 32, 32)

func _ready():
	$Sprite2D.texture = preload("res://Tiles/Tilesetbygpt.png")
	$Sprite2D.region_enabled = true
	$Sprite2D.region_rect = sprite_region
