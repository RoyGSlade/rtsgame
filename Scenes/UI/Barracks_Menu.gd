extends Panel
var barracks: Node2D  # assigned from the building

func _ready():
	$VBoxContainer/TrainSwordsman.connect("pressed", Callable(self, "_on_train_pressed"))

func _on_train_pressed():
	var unit_scene = preload("res://Scenes/Units/Swordsman.tscn")
	var soldier = unit_scene.instantiate()
	soldier.position = barracks.global_position + Vector2(32, 0)  # spawn to the right
	get_tree().get_root().add_child(soldier)
	queue_free()  # close menu


func _on_close_button_pressed():
	queue_free()
