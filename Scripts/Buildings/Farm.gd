extends "res://Scripts/building.gd"

func _ready():
	$ProductionTimer.wait_time = cycle_time
	$ProductionTimer.start()


func _on_timer_timeout() -> void:
	for entry in output:
		if entry.has("resource") and entry.has("amount"):
			ResourceManager.add_resource(entry.resource, entry.amount)
			print("[Farm] +%d %s" % [entry.amount, entry.resource])
