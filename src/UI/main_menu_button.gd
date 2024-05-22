extends Control

@export var button: Button
@export var animation_player: AnimationPlayer
@export var timer_for_animation: Timer
@export var lock: TextureRect
@export var price_label: Label
@export var container_with_price: HBoxContainer
@export var level_name: Label

signal puzzle_pressed(type, is_locked, button)
var type_of_puzzle: String
var locked = true
var price = 0
var base_level_name: String = ""

func _on_button_pressed():
	emit_signal("puzzle_pressed", type_of_puzzle, locked, self)

func set_type_of_puzzle(puzzle_type: String, new_price: int):
	price = new_price
	base_level_name = puzzle_type
	level_name.text = puzzle_type
	price_label.text = str(price)
	type_of_puzzle = puzzle_type
	var prepared_path = "res://Assets/Textures/PuzzleTextures/" + puzzle_type + "/"
	var dir = DirAccess.open(prepared_path)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	button.mouse_filter = Control.MOUSE_FILTER_PASS
	var list_of_images = dir.get_files()
	if (puzzle_type + "_01.png") in list_of_images:
		var random_number_of_puzzle = randi() % 14 + 1
		if random_number_of_puzzle < 10:
			button.icon = load("res://Assets/Textures/PuzzleTextures/" + puzzle_type + "/" + puzzle_type + "_0" + str(random_number_of_puzzle) + ".png")
		else:
			button.icon = load("res://Assets/Textures/PuzzleTextures/" + puzzle_type + "/" + puzzle_type + "_" + str(random_number_of_puzzle) + ".png")
	else:
		button.icon = load("res://Assets/Textures/PuzzleTextures/Ducks.png")
	if not locked:
		lock.queue_free()
		container_with_price.queue_free()

func unlock():
	locked = not locked
	lock.queue_free()
	container_with_price.queue_free()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "change_animation":
		var prepared_path = "res://Assets/Textures/PuzzleTextures/" + type_of_puzzle + "/"
		var dir = DirAccess.open(prepared_path)
		var list_of_images = dir.get_files()
		if (type_of_puzzle + "_01.png") in list_of_images:
			var random_number_of_puzzle = randi() % 14 + 1
			if random_number_of_puzzle < 10:
				button.icon = load("res://Assets/Textures/PuzzleTextures/" + type_of_puzzle + "/" + type_of_puzzle + "_0" + str(random_number_of_puzzle) + ".png")
			else:
				button.icon = load("res://Assets/Textures/PuzzleTextures/" + type_of_puzzle + "/" + type_of_puzzle + "_" + str(random_number_of_puzzle) + ".png")
		else:
			button.icon = load("res://Assets/Textures/PuzzleTextures/Ducks.png")
		animation_player.play("changed_animation")
		timer_for_animation.start(randf_range(60.0, 240.0))

func _on_timer_for_animation_timeout():
	animation_player.play("change_animation")

func translate():
	level_name.text = tr(base_level_name)
