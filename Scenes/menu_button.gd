extends Button

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	show_unit_menu()

func show_unit_menu():
	var menu = preload("res://Scenes/UI/MenuButton_PopUp.tscn").instantiate()
	get_tree().get_root().add_child(menu)

	var popup_position = get_global_position() + Vector2(0, size.y)
	menu.popup(Rect2(popup_position, Vector2(200, 100))) # Adjust size as needed
