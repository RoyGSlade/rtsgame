extends Area2D

signal fully_staffed(building)
signal production_cycle_complete(output_resource, amount)

var building_id := ""
var data := {}
var cycle_time := 10
var workers_required := 1
var output := []
var assigned_workers := []
var is_active := false

func _ready():
	pass # All setup handled after instantiation via setup()

func setup(data_dict: Dictionary) -> void:
	data = data_dict
	building_id = data.get("id", "")
	cycle_time = data.get("cycle_time", 10)
	workers_required = data.get("workers_required", 1)
	output = data.get("output", [])
	_setup_sprite()
	request_employees()

func _setup_sprite():
	var sprite = get_node_or_null("Area2D/Sprite2D")
	if not sprite:
		sprite = get_node_or_null("Sprite2D")

	if sprite and sprite is Sprite2D:
		sprite.texture = preload("res://Tiles/Tilesetbygpt.png")
		if data.has("sprite_region"):
			sprite.region_enabled = true
			sprite.region_rect = Rect2(
				data["sprite_region"][0],
				data["sprite_region"][1],
				data["sprite_region"][2],
				data["sprite_region"][3]
			)
		else:
			sprite.region_enabled = false
	else:
		print("⚠️ Sprite2D not found or invalid in scene:", self.name)

func request_employees():
	BuildingManager.request_workers(self, workers_required)

func assign_worker(worker):
	assigned_workers.append(worker)
	if assigned_workers.size() >= workers_required:
		on_fully_staffed()

func on_fully_staffed():
	is_active = true
	emit_signal("fully_staffed", self)
	start_production_cycle()

func start_production_cycle():
	if not is_active:
		return
	if has_node("ProductionTimer"):
		$ProductionTimer.wait_time = cycle_time
		$ProductionTimer.start()

func _on_ProductionTimer_timeout():
	if not is_active:
		return
	for entry in output:
		if entry.has("resource") and entry.has("amount"):
			ResourceManager.add_resource(entry.resource, entry.amount)
			emit_signal("production_cycle_complete", entry.resource, entry.amount)
	start_production_cycle()

func remove_worker(worker):
	assigned_workers.erase(worker)
	if assigned_workers.size() < workers_required:
		is_active = false
		if has_node("ProductionTimer"):
			$ProductionTimer.stop()

func free():
	for worker in assigned_workers:
		BuildingManager.return_worker(worker)
	assigned_workers.clear()
