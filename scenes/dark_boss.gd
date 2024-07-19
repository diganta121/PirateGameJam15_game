extends CharacterBody2D
const SPEED = 100.0

var player_visible = false
var direction = Vector2.ZERO
var move_timer = 0
var player

func _physics_process(delta):
	if not player:
		return
	if move_timer <= 0:
		move_timer = randi_range(2,200)
	move_timer -= 1
	var distance = global_position.distance_to(player.global_position)

	if distance < 70:
		if randf() < 0.1:
			direction = -direction
			move_timer = 5
	if move_timer <= 2:
		if distance < 300:
			if randf() < 0.1:
				direction = Vector2.RIGHT.rotated(randf_range(0,360))
	if distance > 500:
		direction = global_position.direction_to(player.global_position)

	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func smash_attack():
	for i in $ShockWaveArea2D.get_overlapping_bodies():
		if i.has_method("player_id"):
			i.take_damage(100)

func melee_attack():
	pass 

	
func _on_attack_range_body_entered(body):
	if body.has_method("player_id"):
			player = body
			print("player")
	
