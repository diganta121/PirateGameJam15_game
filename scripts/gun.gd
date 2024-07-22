extends Area2D
var enable_shoot :bool= false


const BULLET_TYPES := {
	"bullet1":"res://scenes/bullet.tscn",
	"bullet2":"res://scenes/bullet2.tscn",
	"bullet3":"res://scenes/bullet3.tscn"
}
@export var bulletType :='bullet3'
var target_pos := Vector2.ZERO


func _physics_process(_delta :float) -> void:
	var enemies = get_overlapping_bodies()
	if enemies.size() > 0 :
		for i in enemies:
			if i.has_method('player_id'):
				enable_shoot = true
				target_pos = i.global_position
				break
		look_at(target_pos)
	else :
		enable_shoot = false

func shoot() -> void:
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

func _on_timer_timeout() -> void:
	if enable_shoot:
		shoot()
