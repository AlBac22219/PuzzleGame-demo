extends ScrollContainer

var can_be_scrolled = false
var start_position = null
var finish_position = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_be_scrolled and Input.is_action_pressed("swipe"):
		start_position = get_global_mouse_position()
		if finish_position == null:
			finish_position = get_global_mouse_position()
		else:
			scroll_horizontal +=(finish_position.x - start_position.x)
			finish_position = get_global_mouse_position()
	else:
		start_position = null
		finish_position = null

func _on_mouse_entered():
	can_be_scrolled = true


func _on_mouse_exited():
	can_be_scrolled = false
