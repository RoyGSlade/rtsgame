extends Node

signal resources_changed(resources: Dictionary)

# Define all resources here. Add/remove as your game expands.
var resources := {
	"gold": 1000,
	"food": 500,
	"wood": 200,
	"stone": 100,
	"iron": 0,
	"steel": 0,
	"population": 0,
	"population_cap": 0,
	# Add more as needed (arrows, bricks, happiness, etc.)
}

# ---- QUERY ----

func get_resource(resource: String) -> int:
	return resources.get(resource, 0)

func get_resources() -> Dictionary:
	return resources.duplicate()

func has_resource(resource: String, amount: int) -> bool:
	return get_resource(resource) >= amount

func has_resources(cost: Dictionary) -> bool:
	for key in cost.keys():
		if not has_resource(key, cost[key]):
			return false
	return true

# ---- MODIFY ----

func add_resource(resource: String, amount: int) -> void:
	resources[resource] = get_resource(resource) + amount
	emit_signal("resources_changed", resources)

func spend_resource(resource: String, amount: int) -> void:
	resources[resource] = max(get_resource(resource) - amount, 0)
	emit_signal("resources_changed", resources)

func spend_resources(cost: Dictionary) -> bool:
	if not has_resources(cost):
		return false
	for key in cost.keys():
		spend_resource(key, cost[key])
	return true

func add_resources(resource_dict: Dictionary) -> void:
	for key in resource_dict.keys():
		add_resource(key, resource_dict[key])


# ---- POPULATION ----

func can_increase_population(amount: int = 1) -> bool:
	return (resources.get("population", 0) + amount) <= resources.get("population_cap", 0)

func increase_population(amount: int = 1) -> bool:
	if can_increase_population(amount):
		resources["population"] += amount
		emit_signal("resources_changed", resources)
		return true
	return false

func decrease_population(amount: int = 1) -> void:
	resources["population"] = max(resources["population"] - amount, 0)
	emit_signal("resources_changed", resources)

# ---- SAVE/LOAD ----
func save_state() -> Dictionary:
	return {
		"resources": resources.duplicate(true)
	}
	
func load_state(data: Dictionary) -> void:
	if data.has("resources"):
		resources = data["resources"]
		emit_signal("resources_changed", resources)

# ---- RESET/UTILITY ----

func reset_resources(new_resources: Dictionary = {}) -> void:
	resources = new_resources.duplicate()
	emit_signal("resources_changed", resources)

# ---- OPTIONAL: For debugging ----
func print_resources():
	print("Current Resources: ", resources)
