extends Area2D
var enable_shoot :bool= false
var mouse_pos :Vector2 = Vector2.ZERO
var enemies
var damage := 10
func _physics_process(_delta :float) -> void:
	mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	if global_rotation_degrees > 90 or global_rotation_degrees < -90:
		%sprite.flip_h = true
	else :
		%sprite.flip_h = false

func _unhandled_input(event) -> void:
	if event.is_action_pressed("attack"):
		attack()

func attack() -> void:
	enemies = get_overlapping_bodies()
	for body in enemies:
		if body.has_method("enemy_id"):
			body.take_damage(10)
			print("enemied")
	enemies = get_overlapping_areas()
	for body in enemies:
		if body.has_method("bullet_id"):
			body.block_bullet()
			print('bulleted')

func _on_timer_timeout() -> void:
	if enable_shoot:
		attack()
