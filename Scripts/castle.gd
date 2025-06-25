extends Node2D
@export var build_radius := 256
@onready var menu_bar = $MenuBar

func can_build_here(pos: Vector2) -> bool:
	return position.distance_to(pos) <= build_radius
	menu_bar.visible = false  # Hide at start
	GameState.connect("population_updated", Callable(self, "update_stats_display"))
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		menu_bar.visible = true
		update_stats_display()

func update_stats_display():
	var total = GameState.total_population
	var cap = GameState.population_cap
	var unemployed = GameState.unemployed_population

	# Set the number labels only!
	$MenuBar/GridContainer/TotalPopNumber.text = "%d / %d" % [total, cap]
	$MenuBar/GridContainer/UnemployedNumber.text = "%d" % unemployed

func _on_close_pressed() -> void:
	menu_bar.visible = false



func _on_area_2d_castle_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		$MenuBar.visible = true
		update_stats_display()
