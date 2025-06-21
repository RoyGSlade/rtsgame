extends Panel

var store_building

#batch amounts 
var batch_amounts = {
	"wood": 20,
	"food": 20,
	"stone": 10
}


# Adjust prices as needed
var buy_prices = { "wood": 20, "food": 20, "stone": 30 }
var sell_prices = { "wood": 10, "food": 10, "stone": 15 }

func _ready():
	$GridContainer/BuyWood.connect("pressed", Callable(self, "_on_buy_pressed").bind("wood"))
	$GridContainer/SellWood.connect("pressed", Callable(self, "_on_sell_pressed").bind("wood"))
	$GridContainer/BuyFood.connect("pressed", Callable(self, "_on_buy_pressed").bind("food"))
	$GridContainer/SellFood.connect("pressed", Callable(self, "_on_sell_pressed").bind("food"))
	$GridContainer/BuyStone.connect("pressed", Callable(self, "_on_buy_pressed").bind("stone"))
	$GridContainer/SellStone.connect("pressed", Callable(self, "_on_sell_pressed").bind("stone"))

var batch_amount = 20  # change this for all resources or make it per-resource

func _on_buy_pressed(resource: String):
	var price = buy_prices[resource] * batch_amount
	if ResourceManager.has_resource("gold", price):
		ResourceManager.spend_resource("gold", price)
		ResourceManager.add_resource(resource, batch_amount)

func _on_sell_pressed(resource: String):
	if ResourceManager.has_resource(resource, batch_amount):
		ResourceManager.spend_resource(resource, batch_amount)
		var payout = sell_prices[resource] * batch_amount
		ResourceManager.add_resource("gold", payout)


func _on_button_pressed() -> void:
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	pass # Replace with function body.


func _on_button_5_pressed() -> void:
	pass # Replace with function body.


func _on_button_6_pressed() -> void:
	pass # Replace with function body.


func _on_close_btn_pressed() -> void:
	queue_free()
