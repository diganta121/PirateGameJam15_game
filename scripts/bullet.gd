extends Area2D

var travel_dist = 0 
@export var DAMAGE := 10
@export var RANGE := 1200
@export var SPEED := 1100
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travel_dist += SPEED * delta
	if travel_dist > RANGE:
		queue_free()


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE)
