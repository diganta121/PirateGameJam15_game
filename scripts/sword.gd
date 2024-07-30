extends Area2D

var enable_shoot : bool = false
var mouse_pos : Vector2 = Vector2.ZERO
var enemies
@onready var gameManager := get_node("/root/Scene/GameManager")
@onready var attack_cooldown_timer := $AttackCooldownTimer

const SPRITES := {
	0: 'sword1',
	1: 'enchanted_sword'
}
var swordState := 0
var prevSwordState := 0
var is_on_cooldown : bool = false
var flipped := false

func _ready() -> void:
	# Initialize the Timer
	attack_cooldown_timer.wait_time = 0.2 # Set cooldown duration to 1 second
	attack_cooldown_timer.one_shot = true

	
func _physics_process(_delta: float) -> void:
	if swordState != prevSwordState:
		%sprite.play(SPRITES[swordState])
	if global_rotation_degrees > 90 or global_rotation_degrees < -90:
		%sprite.flip_h = true
		flipped = true
	else:
		%sprite.flip_h = false
		flipped = false
		
func _unhandled_input(event) -> void:
	if event.is_action_pressed("attack") and not is_on_cooldown:
		attack()

func attack() -> void:
	if is_on_cooldown:
		return
	enemies = get_overlapping_bodies()
	for body in enemies:
		if body.has_method("enemy_id"):
			body.take_damage(gameManager.PLAYER_SWORD_DAMAGE)
			print("enemy attacked")
	
	enemies = get_overlapping_areas()
	for body in enemies:
		if body.has_method("bullet_id"):
			body.block_bullet()
			print('bullet blocked')
	
	# Start cooldown timer
	is_on_cooldown = true
	attack_cooldown_timer.start(0.2)

func _on_timer_timeout() -> void:
	is_on_cooldown = false
