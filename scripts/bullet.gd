extends Area2D

var travel_dist := 0.0
@export var DAMAGE := 10
@export var RANGE := 1200
@export var SPEED := 1100
func _physics_process(delta :float) -> void:
	var direction :Vector2 = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travel_dist += SPEED * delta
	if travel_dist > RANGE:
		queue_free()


func _on_body_entered(body) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE)

func bullet_id() -> int:
	return 0

func block_bullet() -> void:
	print("blocked")
	var c :float= randf()
	if c <0.5:
		SPEED *= -1
	else:
		queue_free()

