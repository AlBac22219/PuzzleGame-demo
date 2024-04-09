extends CharacterBody2D

const SPEED = 400.0
var number_of_puzzle = 0
@export var label_for_number: Label
@export var puzzle_sprite: Sprite2D
var hFrame_count: int
var vFrame_count: int
var count_of_puzzles: int
var new_pos = null

func _ready():
	pass

func _process(delta):
	if new_pos != null:
		velocity = position.direction_to(new_pos)*SPEED
		if position.distance_to(new_pos) > 3.0:
			if position.distance_to(new_pos) < 6.0:
				velocity = Vector2.ZERO
				position = new_pos
				new_pos = null
			else :
				move_and_slide()

func set_puzzle_sprite(path_to_sprite: String):
	puzzle_sprite.texture = load(path_to_sprite)

func get_puzzle_sprite():
	return puzzle_sprite.texture.resource_path

func set_number(number: int):
	if number > 0 and number < count_of_puzzles:
		number_of_puzzle = number
		label_for_number.text = str(number + 1)
		puzzle_sprite.frame = number

func set_frames(hFrame: int, vFrame: int):
	hFrame_count = hFrame
	vFrame_count = vFrame
	count_of_puzzles = hFrame_count * vFrame_count
	puzzle_sprite.hframes = hFrame
	puzzle_sprite.vframes = vFrame
	$Area2D/CollisionShape2D.shape.extents = Vector2(1024/vFrame/2, 1024/hFrame/2)

func get_count_of_puzzle():
	return count_of_puzzles

func get_vFrames():
	return vFrame_count

func get_hFrames():
	return hFrame_count


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		new_pos = ($"../Player_marker".get_old_pos())
	elif area.is_in_group("Check_area"):
		$"../../Puzzle_panel".add_number_of_puzzle(number_of_puzzle)

