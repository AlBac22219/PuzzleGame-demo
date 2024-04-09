extends Control

@export var game_theme: Theme
@export var night_mode_button: Button
const dark_mode_color = Color(0.167, 0.171, 0.178, 1.0)
const dark_mode_shadow = Color(0.573, 0.573, 0.573, 0.588)
const light_mode_color = Color(0.71, 0.71, 0.71, 0.972)
const light_mode_shadow = Color(0.196, 0.196, 0.196, 0.588)
var dark_mode = false
signal closed
signal translate_time

func _ready():
	dark_mode = LoadingGlobalScript.get_night_mode()
	if dark_mode:
		night_mode_button.icon = load("res://Assets/Textures/UI/StyleMode/night_mode.png")
	else:
		night_mode_button.icon = load("res://Assets/Textures/UI/StyleMode/day_mode.png")

func set_dark_mode(new_mode: bool):
	dark_mode = new_mode

func _on_russian_language_pressed():
	TranslationServer.set_locale("ru")
	emit_signal("translate_time")

func _on_english_language_pressed():
	TranslationServer.set_locale("en")
	emit_signal("translate_time")

func _on_turkish_language_pressed():
	TranslationServer.set_locale("tr")
	emit_signal("translate_time")

func _on_close_button_pressed():
	emit_signal("closed")
	queue_free()

func _on_night_mode_button_pressed():
	var styleBox = game_theme.get_stylebox("panel", "Panel")
	if dark_mode:
		styleBox.bg_color = light_mode_color
		styleBox.shadow_color = light_mode_shadow
		night_mode_button.icon = load("res://Assets/Textures/UI/StyleMode/day_mode.png")
		set_dark_mode(false)
	else:
		styleBox.bg_color = dark_mode_color
		styleBox.shadow_color = dark_mode_shadow
		night_mode_button.icon = load("res://Assets/Textures/UI/StyleMode/night_mode.png")
		set_dark_mode(true)
	LoadingGlobalScript.set_night_mode(dark_mode)
	game_theme.set_stylebox("panel", "Panel", styleBox)
	
