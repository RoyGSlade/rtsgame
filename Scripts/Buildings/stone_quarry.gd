extends "res://Scripts/building.gd"
@export var building_id := "stone_quarry"

func _ready():
	print("🔸 StoneQuarry _ready() — building_id =", building_id)
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

# Example: Custom FX or sounds when fully staffed
func on_fully_staffed():
	super.on_fully_staffed()  # Run parent's logic
	# Uncomment next line to add FX:
	# play_quarry_start_fx()

# Example: Custom setup if needed (almost never needed, but shown for reference)
# func setup(data_dict: Dictionary) -> void:
#     .setup(data_dict)
#     # Any unique setup code here

# Example: Special animation/sound on cycle complete (optional)
# func _on_ProductionTimer_timeout():
#     ._on_ProductionTimer_timeout()
#     # Add stone particles, play mining sound, etc.
