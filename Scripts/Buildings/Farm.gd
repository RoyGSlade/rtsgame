extends "res://Scripts/building.gd"

@export var building_id: String = "farm"

var cycle_time: float = 0
var workers_required: int = 0
var output: Array = []

func _ready():
	data = BuildingManager.get_building_data(building_id)
	if data.is_empty():
		push_error("Missing data for building: %s" % building_id)
		return

	cycle_time = data.get("cycle_time", 25)
	workers_required = data.get("workers_required", 0)
	output = data.get("output", [])

	$ProductionTimer.wait_time = cycle_time
	$ProductionTimer.start()


func _on_timer_timeout() -> void:
	for entry in output:
		if entry.has("resource") and entry.has("amount"):
			ResourceManager.add_resource(entry.resource, entry.amount)
			print("[Farm] +%d %s" % [entry.amount, entry.resource])
