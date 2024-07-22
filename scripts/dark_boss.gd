extends CharacterBody2D
const SPEED := 100.0
var player_visible := false
var direction := Vector2.ZERO
var move_timer := 0
var player

@export var health := 300

func _physics_process(_delta: float) -> void:
	if not player:
		return
	if move_timer <= 0:
		move_timer = randi_range(2,200)
	move_timer -= 1
	var distance := global_position.distance_to(player.global_position)

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

func smash_attack() -> void:
	for i in $ShockWaveArea2D.get_overlapping_bodies():
		if i.has_method("player_id") or i.has_method("enemy_id") :
			i.take_damage(80)

func melee_attack() -> void:
	pass 

func _on_attack_range_body_entered(body)-> void:
	if body.has_method("player_id"):
			player = body
			print("player")

func enemy_id() -> int:
	return 2

func take_damage(damage:int)-> void:
	health -= damage
	if health <= 0:
		print('dead')
		queue_free()

func summon_enemies() -> void:
	# every 5 sec summon random amount of enemies 
	# arround the boss 
	# play summon animation 
	const ENEMY_1 := preload("res://scenes/enemy_1.tscn")
	var enemy_char := ENEMY_1.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	
	enemy_char.global_position = global_position.normalized()
	add_child(enemy_char)

func _on_timer_timeout() -> void:
	var num := randi_range(2,9)
	for i in range(num):
		summon_enemies()
