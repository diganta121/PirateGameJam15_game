extends CharacterBody2D
var alive := true
var health := 10.0
var MOB_DAMAGE := 5.0
signal player_dead

var speedVAL := 650
const default_speed := 650
@onready var Sprite = $playerSprite
@onready var timer = $Timer
var animationState := 1
var potionState := 0
const ANIMATION_STATE = {
	1:'walk',
	2:'strength',
	3:'speed'
}

func _physics_process(delta) -> void:
	var direc = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direc * speedVAL 

	move_and_slide()
	if velocity.length() > 0.0:
		if animationState < 1:
			animationState = 1
		if direc.x < 0:
			Sprite.flip_h = true
		else:
			Sprite.flip_h = false
	else:
		if animationState == 1:
			animationState = 0
	playAnimation()
	var over_mobs = %HurtBox.get_overlapping_bodies()
	if over_mobs.size() > 0 :
		health -= MOB_DAMAGE * delta
		if health <= 0.0:
			player_dead.emit()

func player_id() -> int:
	return 1

func playAnimation():
	if animationState == 1:
		Sprite.play("walk")
	elif animationState == 2:
		Sprite.play("strength")
	elif animationState == 3:
		Sprite.play("speed")
	elif animationState == 0:
		Sprite.play("idle")

func strengthplay() -> void:
	timer.start(30)
	animationState = 2
	get_node("/root/Scene/GameManager").PLAYER_SWORD_DAMAGE = 15
	potionState = 2
	speedVAL = 600

func speedplay() -> void:
	timer.start(30)
	animationState = 3
	potionState = 3
	speedVAL = 1800

func _on_timer_timeout() -> void:
	animationState = 1
	MOB_DAMAGE =5.0
	speedVAL =650
