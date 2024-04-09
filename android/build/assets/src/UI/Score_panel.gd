extends Panel

@export var time_label: Label
@export var show_numbers_buttone: CheckButton
var time = 0
var minutes = 0
var hours = 0

func _on_timer_timeout():
	time += 1
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

func translate_time():
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

func get_time():
	return time
