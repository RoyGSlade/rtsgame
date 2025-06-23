extends PopupPanel

func _ready():
	$VBoxContainer/SaveButton.pressed.connect(_on_save_pressed)
	$VBoxContainer/LoadButton.pressed.connect(_on_load_pressed)
	$VBoxContainer/ResetButton.pressed.connect(_on_reset_pressed)

func _on_save_pressed():
	GameState.save_game()
	hide()

func _on_load_pressed():
	GameState.load_game()
	hide()

func _on_reset_pressed():
	#_reset_game()
	hide()


func _on_gui_focus_changed(control):
	if not is_ancestor_of(control):
		hide()

func _on_close_button_pressed():
	queue_free()
