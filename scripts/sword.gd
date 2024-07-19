extends Area2D
var enable_shoot = false
var mouse_pos = 0
func _physics_process(delta):
	mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)

func attack():
	var enemies = get_overlapping_bodies()

func _on_timer_timeout():
	if enable_shoot:
		attack()
