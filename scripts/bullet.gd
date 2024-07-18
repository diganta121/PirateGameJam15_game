extends Area2D
const DAMAGE = 10
var travel_dist = 0

func _physics_process(delta):
	const SPEED = 1100
	const RANGE = 1200
	var direction = Vector2.LEFT.rotated(rotation)
	position += direction * SPEED * delta
	
	travel_dist += SPEED * delta
	
	if travel_dist > RANGE:
		queue_free()


func _on_body_entered(body):
	queue_free()
	if body.has_method("attack"):
		body.attack(DAMAGE)
