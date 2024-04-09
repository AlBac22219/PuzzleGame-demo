extends Control

@export var add_coins: Label
@export var anim_player: AnimationPlayer
@export var coins_label: Label
@export var time_label: Label
var additional_money: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func win(add_money, time):
	coins_label.text = str(LoadingGlobalScript.get_money())
	add_coins.text = "+" + str(floor(add_money))
	print_time(time)
	additional_money = add_money
	anim_player.play("Add_coins_anim")

func print_time(time):
	var hours: int
	var minutes: int
	if not abs(time / 360) == 0:
		hours = abs(minutes / 60)
	if not abs(time / 60) == 0:
		minutes = abs(time / 60)
	if not hours == 0:
		time_label.text = ""
		time_label.text += tr(str("TIME_LABEL"))
		time_label.text += str(": ", hours)
		time_label.text += tr("HOURS_FOR_LABEL") 
		time_label.text += str(" ", (minutes - hours * 60))
		time_label.text += tr("MINUTES_FOR_LABEL")
		time_label.text += str(" ", (time - hours*360 - minutes*60), " ")
		time_label.text += tr("SECONDS_FOR_LABEL")
	elif not minutes == 0:
		time_label.text = ""
		time_label.text += tr(str("TIME_LABEL"))
		time_label.text += str(": ")
		time_label.text += str(" ", (minutes), " ")
		time_label.text += tr("MINUTES_FOR_LABEL")
		time_label.text += str(" ", (time - minutes*60), " ")
		time_label.text += tr("SECONDS_FOR_LABEL")
	else:
		time_label.text = ""
		time_label.text += tr(str("TIME_LABEL"))
		time_label.text += str(": ")
		time_label.text += str(" ", time, " ")
		time_label.text += tr("SECONDS_FOR_LABEL")

func _on_animation_player_animation_finished(anim_name):
	add_coins.queue_free()
	anim_player.queue_free()
	await LoadingGlobalScript.set_money(LoadingGlobalScript.get_money() + floor(additional_money))
	coins_label.text = str(LoadingGlobalScript.get_money())
