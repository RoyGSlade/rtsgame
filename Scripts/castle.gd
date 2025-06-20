extends Node2D
@export var build_radius := 256

func can_build_here(pos: Vector2) -> bool:
	return position.distance_to(pos) <= build_radius
