extends CharacterBody2D
const SPEED := 100.0
@onready var player := get_node("/root/Scene/Player")
var player_visible := false
var direction := Vector2.ZERO
@export var health := 50

func _ready() -> void:
	velocity = Vector2.ZERO
	move_and_slide()

func _physics_process(_delta:float) -> void:
	var distance := global_position.distance_to(player.global_position)
	if distance < 70:
		if randf() < 0.1:
			direction = -direction
	if distance < 150:
		if randf() < 0.1:
			direction = Vector2.RIGHT.rotated(randf_range(0,360))
	elif distance > 600:
		direction = global_position.direction_to(player.global_position)

	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func enemy_id() -> int:
	return 1

func take_damage(damage: int)-> void:
	health -= damage
	if health <= 0:
		print('dead')
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()
