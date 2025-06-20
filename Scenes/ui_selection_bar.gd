extends HBoxContainer
func _on_Button_pressed():
	GameState.placement_mode = true
	GameState.placing_type = "Farm"
	GameState.placing_category = "building"

func _on_Button2_pressed():
	GameState.placement_mode = true
	GameState.placing_type = "Sawmill"
	GameState.placing_category = "building"

# Repeat or dynamically bind if you want to scale
