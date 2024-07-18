extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -100.0
var player_visible = 0


func _physics_process(delta):
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func _on_area_2d_body_entered(body):
	if body.has_method('player_id'):
		player_visible = body.player_id()



func _on_area_2d_body_exited(body):
	if body.has_method('player_id'):
		if player_visible == body.player_id():
			player_visible = 0



func _on_timer_timeout():
	if player_visible !=0:
		
