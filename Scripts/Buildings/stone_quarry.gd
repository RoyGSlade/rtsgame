extends "res://Scripts/building.gd"

# --- Optionally override or extend parent behavior below ---

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
