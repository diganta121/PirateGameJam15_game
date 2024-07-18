extends CharacterBody2D

const BASE_SPEED = 400.0
const BOOST = 500.0

var speed = BASE_SPEED

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		
	#if velocity.x != 0:
		#$AnimatedSprite2D.flip_h = velocity.x > 0
	move_and_slide()

func player_id():
	return 2
