extends "res://Scripts/building.gd"

var cycle_time := 0
var workers_required := 0
var output := []
@export var building_id := "stone_quarry"

func _ready():
	data = BuildingManager.get_building_data(building_id)

	if data.is_empty():
		push_error("Missing building data for ID: " + building_id)
		return

	# Pull key values
	cycle_time = data.get("cycle_time", 30)
	workers_required = data.get("workers_required", 0)
	output = data.get("output", [])


	# Start production loop
	$ProductionTimer.wait_time = cycle_time
	$ProductionTimer.start()



func _on_production_timer_timeout():
	for entry in output:
		if entry.has("resource") and entry.has("amount"):
			ResourceManager.add_resource(entry.resource, entry.amount)
			print("[StoneQuarry] +", entry.amount, entry.resource)
