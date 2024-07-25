extends CharacterBody2D
var health := 100.0
var MOB_DAMAGE := 5.0
signal player_dead
var speedVAL := 650
const default_speed := 650
@onready var Sprite = $playerSprite
@onready var timer = $Timer
var animationState := 1 
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
		Sprite.play("walk")
		if direc.x < 0:
			Sprite.flip_h = true
		else:
			Sprite.flip_h = false
	else :
		Sprite.play("idle")
		
	var over_mobs = %HurtBox.get_overlapping_bodies()
	if over_mobs.size() > 0 :
		health -= MOB_DAMAGE * delta
		if health <= 0.0:
			player_dead.emit()

func player_id() -> int:
	return 1

func aniplay():
	timer.start()
	Sprite.play("strength")
	MOB_DAMAGE = 15.0

func speedplay():
	timer.start()
	Sprite.play("speed")
	speedVAL = 1800

func _on_timer_timeout():
	Sprite.play("idle")
	MOB_DAMAGE =5.0
	speedVAL =650
