extends Panel

@export var puzzle: CharacterBody2D
@export var final_image: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func make_image():
	final_image.texture = load(str(puzzle.get_puzzle_sprite()))
	final_image.global_scale = Vector2(0.375, 0.375)
