extends Node
var placement_mode := false
var placing_type := ""
var placing_category := ""  # "building" or "unit"
var player_castle : Node2D

func clear_placement_mode():
	placement_mode = false
	placing_type = ""
	placing_category = ""
