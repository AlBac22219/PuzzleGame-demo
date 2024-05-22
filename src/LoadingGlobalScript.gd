extends Node

var night_mode = false
var money = 0
var global_price = 1000

func load_screen_to_scene(target: String) -> void:
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_night_mode(mode: bool):
	night_mode = mode

func get_night_mode():
	return night_mode

func calculate_additional_money(time, optimal_time, max_money):
	return max_money * (optimal_time / time)

func set_money(newMoney):
	money = newMoney

func get_money():
	return money

func get_global_price():
	return global_price
