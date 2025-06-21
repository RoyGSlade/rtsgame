extends HBoxContainer
func _on_farmbtn_pressed():
	get_tree().get_root().get_node("Main").start_building_placement("farm")


func _on_sawmillbtn_pressed():
	get_tree().get_root().get_node("Main").start_building_placement("sawmill")



func _on_barracksbtn_pressed():
	get_tree().get_root().get_node("Main").start_building_placement("barracks")


func _on_stonebtn_pressed():
	get_tree().get_root().get_node("Main").start_building_placement("stone_quarry")


func _on_marketbtn_pressed() -> void:
	get_tree().get_root().get_node("Main").start_building_placement("marketplace")
