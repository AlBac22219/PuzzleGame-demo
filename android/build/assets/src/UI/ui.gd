extends Control

@export var puzzle_panel: Panel
@export var puzzle_fot_setting: CharacterBody2D
@export var final_image_panel: Panel
@export var timer: Timer
@export var score_panel: Panel
@export var score_timer: Timer
@export var player: Marker2D
var hide_numbers = true
var optimal_time: float
var max_money: float

# Called when the node enters the scene tree for the first time.
func _ready():
	puzzle_fot_setting.set_frames(3,3)
	puzzle_fot_setting.set_puzzle_sprite("res://Assets/Textures/PuzzleTextures/Ducks.png")
	final_image_panel.make_image()
	puzzle_panel.start_game()
	puzzle_panel.randomize_puzzle(3)
	optimal_time = 60.0
	max_money = 500.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_check_button_pressed():
	var puzzles_numbers = get_tree().get_nodes_in_group("numbersOfPuzzle")
	if hide_numbers:
		for i in puzzles_numbers:
			i.show()
	else:
		for i in puzzles_numbers:
			i.hide()
	hide_numbers = not hide_numbers

func _closed_language_config():
	timer.paused = false
	player.set_pause(false)
	
func _translate_time():
	score_panel.translate_time()

func _on_button_pressed():
	player.set_pause(true)
	timer.paused = true
	var config_language_scene = preload("res://src/UI/change_language_gui.tscn")
	var config_language = config_language_scene.instantiate()
	config_language.connect("closed", _closed_language_config)
	config_language.connect("translate_time", _translate_time)
	add_child(config_language)


func _on_puzzle_panel_game_over():
	score_timer.stop()
	$Main_panel/Score_panel/Language_setting_button.disabled = true
	var additional_money = LoadingGlobalScript.calculate_additional_money(score_panel.get_time(), optimal_time, max_money)
	var win_scene_preloaded = preload("res://src/UI/win_panel.tscn")
	var win_scene = win_scene_preloaded.instantiate()
	win_scene.win(additional_money, score_panel.get_time())
	add_child(win_scene)
	print(LoadingGlobalScript.get_money())
