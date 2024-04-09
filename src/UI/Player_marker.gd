extends Marker2D

signal moved
const min_swipe_lenght = 200
var old_pos: Vector2
var startPos: Vector2
var curPos: Vector2
var speedForPlayerY: float
var speedForPlayerX: float
var threshold = 70
var can_move = true
var paused = false
var game_over = false
var time_for_timer = 0.8
@export var timer_for_movement: Timer
@onready var r: ReferenceRect = $"../ReferenceRect"


func _ready():
	pass

func set_pause(pause: bool):
	paused = pause

func get_old_pos():
	return old_pos

func set_speed_y(ySpeed):
	speedForPlayerY = ySpeed

func set_speed_x(xSpeed):
	speedForPlayerX = xSpeed*2

func set_game_over(game_overed: bool):
	game_over = game_overed

func _process(delta):
	pass

func _input(event):
	if not paused and not game_over:
		if event.is_action_pressed("move_down"):
			move_down()
			emit_signal("moved")
		elif  event.is_action_pressed("move_up"):
			move_up()
			emit_signal("moved")
		elif event.is_action_pressed("move_left"):
			move_left()
			emit_signal("moved")
		elif event.is_action_pressed("move_right"):
			move_right()
			emit_signal("moved")
		elif event.is_action_pressed("swipe"):
			startPos = get_global_mouse_position()
		elif event.is_action_released("swipe"):
			curPos = get_global_mouse_position()
			calculate_swiping()

func calculate_swiping():
	var horisontal_swipe = curPos.x - startPos.x
	var vertival_swipe = curPos.y - startPos.y
	if abs(horisontal_swipe) > min_swipe_lenght or abs(vertival_swipe) > min_swipe_lenght:
		if abs(horisontal_swipe) > abs(vertival_swipe):
			if horisontal_swipe > 0:
				move_left()
				emit_signal("moved")
			else:
				move_right()
				emit_signal("moved")
		else:
			if vertival_swipe > 0:
				move_up()
				emit_signal("moved")
			else:
				move_down()
				emit_signal("moved")

func move_right():
	if future_position_in_panel(Vector2(position.x + speedForPlayerX, position.y)) and can_move:
		old_pos = position
		position.x += speedForPlayerX
		can_move = false
		timer_for_movement.start(time_for_timer)
		

func move_left():
	if future_position_in_panel(Vector2(position.x - speedForPlayerX, position.y)) and can_move:
		old_pos = position
		position.x -= speedForPlayerX
		can_move = false
		timer_for_movement.start(time_for_timer)

func move_up():
	if future_position_in_panel(Vector2(position.x, position.y - speedForPlayerY)) and can_move:
		old_pos = position
		position.y -= speedForPlayerY
		can_move = false
		timer_for_movement.start(time_for_timer)

func move_down():
	if future_position_in_panel(Vector2(position.x, position.y + speedForPlayerY)) and can_move:
		old_pos = position
		position.y += speedForPlayerY
		can_move = false
		timer_for_movement.start(time_for_timer)

func future_position_in_panel(future_position: Vector2):
	var rect = Rect2(r.position, r.size)
	return rect.has_point(future_position)
