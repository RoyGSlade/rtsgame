extends Camera2D

@export var cam_speed := 300
var dragging := false
var last_mouse_pos := Vector2.ZERO

func _process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	position += input.normalized() * cam_speed * delta

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if GameState.placement_mode:
			var mouse_pos = get_global_mouse_position()
			var snapped_pos = mouse_pos.snapped(Vector2(32, 32))
			match GameState.placing_type:
				"Farm":
					var farm = preload("res://Scenes/Buildings/building.tscn").instantiate()
					farm.position = snapped_pos
					get_parent().add_child(farm)  # Or $Buildings if you're organizing
				# Add more as needed

			# Clear mode after placing
		GameState.placement_mode = false
	GameState.placing_type = ""
