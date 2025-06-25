extends Node
signal population_updated(total, unemployed, cap)
var placement_mode := false
var placing_type := ""
var placing_category := ""  # "building" or "unit"
var player_castle : Node2D
var total_population = 10
var unemployed_population = 10
var population_cap = 10  # Increases with houses


func update_population_stats():
	total_population = clamp(total_population, 0, population_cap)
	unemployed_population = clamp(unemployed_population, 0, total_population)
	emit_signal("population_updated", total_population, unemployed_population, population_cap)

func clear_placement_mode():
	placement_mode = false
	placing_type = ""
	placing_category = ""

func save_game() -> void:
	var save_data = {
		"resources": ResourceManager.save_state(),
		"buildings": BuildingManager.save_placed_buildings()
	}
	
	#THIS FOLDER WILL WORK IN THE GODOT EDITOR BUT WILL FAIL IN EXPORTD BUILDS. CHANGE TO A USER:// FOLDER BEFORE GO LIVE. -AM
	var dir := DirAccess.open("res://")
	if dir == null:
		push_error("Failed to open res:// directory.")
	else:
		if not dir.dir_exists("Data/SavedGame"):
			var success := dir.make_dir_recursive("Data/SavedGame")
			if success != OK:
				push_error("Failed to create directory: Data/SavedGame")	
	
	var file = FileAccess.open("res://Data/SavedGame/savegame.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data, "\t"))
	file.close()

func load_game() -> void:
	if not FileAccess.file_exists("res://Data/SavedGame/savegame.json"):
		print("No save file found.")
		return
	var file = FileAccess.open("res://Data/SavedGame/savegame.json", FileAccess.READ)
	var save_data = JSON.parse_string(file.get_as_text())
	file.close()

	if typeof(save_data) == TYPE_DICTIONARY:
		if save_data.has("resources"):
			ResourceManager.load_state(save_data["resources"])
		if save_data.has("buildings"):
			BuildingManager.load_placed_buildings(save_data["buildings"])
