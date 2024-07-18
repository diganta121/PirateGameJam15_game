extends CharacterBody2D

@onready var player = get_node("/root/TestScene/Player")

const SPEED = 100.0
var player_visible = false

var c = 0
func _physics_process(delta):
	c = 0
	for body in $Area2D.get_overlapping_bodies():
		if body.has_method('player_id'):
			c=1
			player_visible = true
	if c == 0:
		player_visible = false

	# Get the input direction and handle the movement/deceleration.
	if player_visible:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()
