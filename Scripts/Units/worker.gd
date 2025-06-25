extends CharacterBody2D

@export var move_speed := 80.0
@onready var anim_sprite := $AnimatedSprite2D

var current_task := ""
var target_position := Vector2.ZERO
var facing := "right"

func _ready():
	play_idle("right")

func set_task(task_name: String, position: Vector2):
	current_task = task_name
	target_position = position

func play_idle(direction: String):
	facing = direction
	var anim = "idle_" + direction
	if anim_sprite.sprite_frames.has_animation(anim):
		anim_sprite.play(anim)

func _physics_process(delta):
	if current_task != "":
		var dir = (target_position - global_position)
		if dir.length() > 8:
			facing = "right" if dir.x >= 0 else "left"
			velocity = dir.normalized() * move_speed
		else:
			velocity = Vector2.ZERO
			current_task = ""
		move_and_slide()
		play_idle(facing)
	else:
		velocity = Vector2.ZERO
		play_idle(facing)
