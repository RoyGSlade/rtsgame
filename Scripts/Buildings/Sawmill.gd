extends "res://Scripts/building.gd"

@export var building_id: String = "sawmill"

var cycle_time: float = 0
var workers_required: int = 0
var output: Array = []

func _ready():
	# Pull our data out of the JSON
	var data = BuildingManager.get_building_data(building_id)
	if data.is_empty():
		push_error("Missing data for building: %s" % building_id)
		return

	cycle_time = data.get("cycle_time", 30)
	workers_required = data.get("workers_required", 0)
	output = data.get("output", [])

	# Start the production timer
	$ProductionTimer.wait_time = cycle_time
	$ProductionTimer.start()

func _on_production_timer_timeout() -> void:
	for entry in output:
		if entry.has("resource") and entry.has("amount"):
			ResourceManager.add_resource(entry.resource, entry.amount)
			print("[Sawmill] +%d %s" % [entry.amount, entry.resource])
