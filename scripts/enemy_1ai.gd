extends CharacterBody2D
const SPEED = 100.0
@onready var player = get_node("/root/TestScene/Player")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _input(event):
	pass
