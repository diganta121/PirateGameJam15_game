extends Area2D
var enable_shoot :bool= false
var player_visible := true
@onready var GameManager = get_node("/root/Scene/GameManager")
const BULLET_TYPES := {
	"bullet1":"res://scenes/bullet.tscn",
	"bullet2":"res://scenes/bullet2.tscn",
}
@export var bulletType := 'bullet3'
var target_pos := Vector2.ZERO

func _ready():
	var enemies = get_overlapping_bodies()
	if enemies.size() > 0:
		for i in enemies:
			if i.has_method('player_id'):
				enable_shoot = true
				if player_visible:
					target_pos = i.global_position
				break
		look_at(target_pos)
func _physics_process(_delta :float) -> void:
	if not player_visible:
		enable_shoot = true
		print("invis player")
		if GameManager.PLAYER_VISIBLE :
			player_visible = true
		return
	else:
		if not GameManager.PLAYER_VISIBLE:
			player_visible = false
		var enemies = get_overlapping_bodies()
		if enemies.size() > 0:
			for i in enemies:
				if i.has_method('player_id'):
					enable_shoot = true
					if player_visible:
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
func player_invis():
	player_visible = false

