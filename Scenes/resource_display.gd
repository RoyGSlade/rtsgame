extends GridContainer
@onready var labels := {
	"gold": $Gold,
	"food": $Food,
	"wood": $Wood,
	"stone": $Stone
}

func _ready():
	ResourceManager.connect("resources_changed", Callable(self, "_on_resources_changed"))
	_on_resources_changed(ResourceManager.get_resources())

func _on_resources_changed(updated: Dictionary):
	for key in labels:
		if updated.has(key):
			labels[key].text = "%s: %d" % [key.capitalize(), updated[key]]
