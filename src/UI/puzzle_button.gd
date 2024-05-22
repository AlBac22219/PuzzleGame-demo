extends Control

signal pressed()

@export var button: Button

var base_path: String = ""

func init(puzzle_type: String, number_of_puzzle: int):
	var prepared_path = "res://Assets/Textures/PuzzleTextures/" + puzzle_type + "/"
	var dir = DirAccess.open(prepared_path)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	button.mouse_filter = Control.MOUSE_FILTER_PASS
	var list_of_images = dir.get_files()
	if number_of_puzzle < 10:
		button.icon = load("res://Assets/Textures/PuzzleTextures/" + puzzle_type + "/" + puzzle_type + "_0" + str(number_of_puzzle) + ".png")
		base_path = "res://Assets/Textures/PuzzleTextures/" + puzzle_type + "/" + puzzle_type + "_0" + str(number_of_puzzle) + ".png"
	else:
		button.icon = load("res://Assets/Textures/PuzzleTextures/" + puzzle_type + "/" + puzzle_type + "_" + str(number_of_puzzle) + ".png")
		base_path = "res://Assets/Textures/PuzzleTextures/" + puzzle_type + "/" + puzzle_type + "_" + str(number_of_puzzle) + ".png"
