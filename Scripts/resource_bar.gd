extends HBoxContainer
@onready var labels := $"../ResourceDisplay".get_children()

func _ready():
	ResourceManager.connect("resources_changed", Callable(self, "_on_resources_changed"))
	_on_resources_changed(ResourceManager.get_resources())

func _on_resources_changed(res: Dictionary) -> void:
	for label in labels:
		var key = label.name.to_lower()      # Label node named "Gold", "Stone", etc.
		if res.has(key):
			label.text = "%s: %d" % [ key.capitalize(), res[key] ]
