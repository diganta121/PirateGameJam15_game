extends Area2D
var enable_shoot = false
func _physics_process(delta):
	var enemies = get_overlapping_bodies()
	if enemies.size() > 0 :
		enable_shoot = true
		var targer_enemy = enemies.front()
		look_at(targer_enemy.global_position)
	else :
		enable_shoot = false
		
func shoot():
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

func _on_timer_timeout():
	if enable_shoot:
		shoot()
