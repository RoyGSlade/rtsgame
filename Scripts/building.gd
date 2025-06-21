extends Node2D
var data := {}

func _ready():
	pass    # Remove JSON loading here entirely!
	# Only do simple scene setup if needed, but NO data loading.

func setup(data_dict: Dictionary) -> void:
	data = data_dict

	var sprite = get_node_or_null("Area2D/Sprite2D")
	if not sprite:
		sprite = get_node_or_null("Sprite2D")

	if sprite and sprite is Sprite2D:
		sprite.texture = preload("res://Tiles/Tilesetbygpt.png")

		if data.has("sprite_region"):
			sprite.region_enabled = true
			sprite.region_rect = Rect2(
				data["sprite_region"][0],
				data["sprite_region"][1],
				data["sprite_region"][2],
				data["sprite_region"][3]
			)
		else:
			sprite.region_enabled = false
	else:
		print("⚠️ Sprite2D not found or invalid in scene:", self.name)
