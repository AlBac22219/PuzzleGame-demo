extends ScrollContainer

@export var timer: Timer
@export var h_box_cont: HBoxContainer
var can_be_scrolled = false
var start_position = null
var finish_position = null
var finished_swipe = true
var old_horizontal_pos = null
var state = 0
var is_paused = false

func _ready():
	load_levels()

func load_levels():
	var list_of_levels = ["Animals", "Anime", "Cars", "Fantasy", "Technology", "Space"]
	for i in list_of_levels:
		var preloaded_scene = preload("res://src/UI/main_menu_button.tscn")
		var typed_scene = preloaded_scene.instantiate()
		typed_scene.set_type_of_puzzle(i, LoadingGlobalScript.get_global_price())
		typed_scene.connect("puzzle_pressed", _on_puzzle_button_pressed)
		$HBoxContainer.add_child(typed_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_paused:
		return
	if can_be_scrolled and Input.is_action_pressed("swipe"):
		state += 350 * delta
		if state > 1000:
			state = 51
		if state>50:
			finished_swipe = false
			start_position = get_global_mouse_position()
			if finish_position == null:
				finish_position = get_global_mouse_position()
			else:
				old_horizontal_pos = scroll_horizontal
				scroll_horizontal +=(finish_position.x - start_position.x)
				finish_position = get_global_mouse_position()
	else:
		state = 0
		start_position = null
		finish_position = null
		finished_swipe = true

func _input(event):
	if event.is_action_released("swipe") and state > 50:
		timer.start(0.5)

func _on_mouse_entered():
	can_be_scrolled = true


func _on_mouse_exited():
	can_be_scrolled = false

func _on_puzzle_button_pressed(puzzle_type, locked, object):
	if finished_swipe:
		match puzzle_type:
			"Anime":
				print("Наррууутоооо!!!")
				if locked:
					print("А, не")
					var scene = preload("res://src/UI/unlock_level_panel.tscn")
					var unlock_level = scene.instantiate()
					unlock_level.object = object
					$"../../..".add_child(unlock_level)
			"Animals":
				print("-Зебра")
				if locked:
					print("А, не")
					var scene = preload("res://src/UI/unlock_level_panel.tscn")
					var unlock_level = scene.instantiate()
					unlock_level.object = object
					$"../../..".add_child(unlock_level)
			"Cars":
				print("Я не хуилаЕбаная")
				if locked:
					print("А, не")
					var scene = preload("res://src/UI/unlock_level_panel.tscn")
					var unlock_level = scene.instantiate()
					unlock_level.object = object
					$"../../..".add_child(unlock_level)
			"Fantasy":
				print("Dungeon")
				if locked:
					print("А, не")
					var scene = preload("res://src/UI/unlock_level_panel.tscn")
					var unlock_level = scene.instantiate()
					unlock_level.object = object
					$"../../..".add_child(unlock_level)
			"Technology":
				print("Киберпанк")
				if locked:
					print("А, не")
					var scene = preload("res://src/UI/unlock_level_panel.tscn")
					var unlock_level = scene.instantiate()
					unlock_level.object = object
					$"../../..".add_child(unlock_level)
			"Space":
				print("Шепард, мы все проебали")
				if locked:
					print("А, не")
					var scene = preload("res://src/UI/unlock_level_panel.tscn")
					var unlock_level = scene.instantiate()
					unlock_level.object = object
					$"../../..".add_child(unlock_level)

func _on_timer_timeout():
	finished_swipe = true

func _on_button_pressed():
	var config_language_scene = preload("res://src/UI/change_language_gui.tscn")
	var config_language = config_language_scene.instantiate()
	config_language.connect("closed", _closed_language_config)
	config_language.connect("translate_time", _translate_time)
	is_paused = true
	$"../../..".add_child(config_language)

func _closed_language_config():
	timer.paused = false
	is_paused = false

func _translate_time():
	for i in h_box_cont.get_children():
		i.translate()
