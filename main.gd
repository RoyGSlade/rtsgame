extends Node2D

func _ready():
	var castle = preload("res://Scenes/Buildings/Castle.tscn").instantiate()
	castle.position = Vector2(512, 512)
	$Buildings.add_child(castle)
	GameState.player_castle = castle

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not GameState.placement_mode:
			return

		var pos = get_global_mouse_position()
		
		# Check build zone
		if GameState.player_castle and GameState.player_castle.can_build_here(pos):
			var building = BuildingManager.spawn_building(GameState.placing_type, pos)
			if building:
				$Buildings.add_child(building)
				GameState.clear_placement_mode()
		else:
			print("Too far from castle to build!")
