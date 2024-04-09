extends Panel

signal game_over
@export var puzzle: CharacterBody2D
@export var marker_for_puzzles: Marker2D
@export var player_position: Marker2D
@export var score_timer: Timer
var array_of_puzzles = []
var array_of_numbers = []

func start_game():
	var count_of_puzzle = puzzle.get_count_of_puzzle()
	var vFrame_count = puzzle.get_vFrames()
	var hFrame_count = puzzle.get_hFrames()
	var future_array_of_puzzles = []
	marker_for_puzzles.position.x = (1024/hFrame_count)/2
	marker_for_puzzles.position.y = (1024/vFrame_count)/2
	var number = 0
	var number_of_puzzle = 0
	for i in range(count_of_puzzle):
		var scene = preload("res://src/Puzzle/puzzle.tscn")
		var puzzle_instance = scene.instantiate()
		puzzle_instance.set_frames(hFrame_count,vFrame_count)
		puzzle_instance.position = marker_for_puzzles.position
		puzzle_instance.set_number(number_of_puzzle)
		puzzle_instance.set_puzzle_sprite(puzzle.get_puzzle_sprite())
		future_array_of_puzzles.append(puzzle_instance)
		add_child(puzzle_instance)
		if number < hFrame_count - 1:
			number+=1
			marker_for_puzzles.position.x += 1024/hFrame_count
		else:
			number = 0
			marker_for_puzzles.position.y += 1024/vFrame_count
			marker_for_puzzles.position.x = (1024/hFrame_count)/2
		number_of_puzzle += 1
	future_array_of_puzzles[future_array_of_puzzles.size()-1].queue_free()
	future_array_of_puzzles.remove_at(future_array_of_puzzles.size()-1)
	marker_for_puzzles.position.x = -1024
	marker_for_puzzles.position.y = -1024
	player_position.set_speed_y(1024/vFrame_count)
	player_position.set_speed_x((1024/hFrame_count)/2)
	array_of_puzzles = future_array_of_puzzles

func randomize_puzzle(how_much_times: int):
	var random_array_of_puzzle = []
	var size_of_puzzle_array = array_of_puzzles.size()
	for i in range(how_much_times):
		for j in range(size_of_puzzle_array):
			var random_puzzle = randi_range(0,array_of_puzzles.size() - 1)
			random_array_of_puzzle.append(array_of_puzzles[random_puzzle])
			array_of_puzzles.remove_at(random_puzzle)
		array_of_puzzles = random_array_of_puzzle
	set_puzzles()
	var puzzles_numbers = get_tree().get_nodes_in_group("numbersOfPuzzle")
	for i in puzzles_numbers:
			i.hide()

func set_puzzles():
	var vFrame_count = puzzle.get_vFrames()
	var hFrame_count = puzzle.get_hFrames()
	var number = 0
	marker_for_puzzles.position.x = (1024/hFrame_count)/2
	marker_for_puzzles.position.y = (1024/vFrame_count)/2
	for i in range(array_of_puzzles.size()):
		array_of_puzzles[i].position = marker_for_puzzles.position
		if number < hFrame_count - 1:
			number+=1
			marker_for_puzzles.position.x += 1024/hFrame_count
		else:
			number = 0
			marker_for_puzzles.position.y += 1024/vFrame_count
			marker_for_puzzles.position.x = (1024/hFrame_count)/2
	player_position.position = marker_for_puzzles.position
	marker_for_puzzles.position.x = -1024
	marker_for_puzzles.position.y = -1024

func move_marker():
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 0.01
	timer.one_shot = true
	var vFrame_count = puzzle.get_vFrames()
	var hFrame_count = puzzle.get_hFrames()
	marker_for_puzzles.position.x = (1024/hFrame_count)/2
	marker_for_puzzles.position.y = (1024/vFrame_count)/2
	timer.start()
	await timer.timeout
	var number = 0
	for i in range(array_of_puzzles.size()):
		timer.start()
		if number < hFrame_count - 1:
			number+=1
			marker_for_puzzles.position.x += 1024/hFrame_count
		else:
			number = 0
			marker_for_puzzles.position.y += 1024/vFrame_count
			marker_for_puzzles.position.x = (1024/hFrame_count)/2
		await timer.timeout
	marker_for_puzzles.position.x = -1024
	marker_for_puzzles.position.y = -1024
	timer.queue_free()

func check_puzzle() -> bool:
	var is_you_win = false
	array_of_numbers.remove_at(0)
	for i in array_of_numbers.size() - 2:
		if array_of_numbers[i] == array_of_numbers[i+1]-1:
			is_you_win = true
		else:
			is_you_win = false
			array_of_numbers.clear()
			break
	return is_you_win

func add_number_of_puzzle(number: int):
	array_of_numbers.append(number)

func _on_area_2d_area_entered(area):
	if area.is_in_group("Check_area"):
		add_number_of_puzzle(-1)

func _on_timer_for_movement_timeout():
	await move_marker()
	player_position.can_move = true
	if check_puzzle():
		player_position.set_game_over(true)
		emit_signal("game_over")
	else:
		array_of_numbers.clear()
