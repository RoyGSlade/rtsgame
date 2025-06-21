extends Node2D

func _ready():
	var castle = preload("res://Scenes/Buildings/Castle.tscn").instantiate()
	castle.position = Vector2(512, 512)
	$Buildings.add_child(castle)
	GameState.player_castle = castle

func _unhandled_input(event):
	if ghost_building and event is InputEventMouseButton and event.pressed:
		if event.is_action("Select"):
			# Place building
			var pos = ghost_building.position
			ghost_building.queue_free()
			ghost_building = null
			BuildingManager.spawn_building(placing_building, pos)
			placing_building = ""
			GameState.placement_mode = false
		elif event.is_action("Deselect"):
			# Cancel placement
			ghost_building.queue_free()
			ghost_building = null
			placing_building = ""
			GameState.placement_mode = false

var placing_building: String = ""
var ghost_building: Node2D = null

func start_building_placement(building_id: String) -> void:
	# Remove any old ghost
	if ghost_building:
		ghost_building.queue_free()
	placing_building = building_id

	# Instance the ghost
	var scene_path = "res://Scenes/Buildings/%s.tscn" % building_id
	ghost_building = load(scene_path).instantiate() as Node2D

	# Make it semi-transparent
	var sprite = ghost_building.get_node("Area2D/Sprite2D") as Sprite2D
	sprite.modulate.a = 0.5


	add_child(ghost_building)

func _process(_delta: float) -> void:
	# Follow mouse & snap to 32×32 grid
	if ghost_building:
		ghost_building.position = get_global_mouse_position().snapped(Vector2(32, 32))
