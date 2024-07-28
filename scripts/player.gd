extends CharacterBody2D
class_name Player
var alive := true
var health := 100.0 
var MOB_DAMAGE := 5.0
@export var scene_name := ''
signal player_dead

var speedVAL :int= 650
const default_speed :int= 650
@warning_ignore("untyped_declaration")
@onready var Sprite = $playerSprite
@warning_ignore("untyped_declaration")
@onready var timer = $Timer
var animationState :int= 1
var prevAnimationState :int= 1 
const ANIMATION_STATE := {
	1:'walk',
	2:'strength',
	3:'speed'
}

func _ready():
	playAnimation()
	animationState = 0
	
func _physics_process(delta : float) -> void:
	
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
			
	var over_mobs = %HurtBox.get_overlapping_bodies()
	if over_mobs.size() > 0 :
		health -= MOB_DAMAGE * delta
		if health <= 0.0:
			player_dead.emit()
			print("player dead")
	if animationState != prevAnimationState:
		playAnimation()
		prevAnimationState = animationState

func player_id() -> int:
	return 1

func playAnimation() -> void:
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
	speedVAL = 600

func speedplay() -> void:
	timer.start(30)
	animationState = 3
	speedVAL = 1800

func invisEffect() -> void:
	#disable colloision shape
	pass

func _on_timer_timeout() -> void:
	animationState = 1
	MOB_DAMAGE = 1.0
	speedVAL = 650

func take_damage(dmg: int) -> void:
	health -= dmg
	if health < 0:
		health = 0
		player_dead.emit()
		alive = false
	$healthBar.value = health

func reset_potions() -> void:
	animationState = 1
	MOB_DAMAGE = 5.0
		
#dialog system
const lines: Array[String] = [
	"Marco: Hey, you seem pretty strong!",
	"Asta: Wanna spar?",
	"Luffy: Wait...",
	"Naruto: I shouldn't waste my energy before an important battle."
	]
var ran =false
func _unhandled_input(event):
	if event.is_action_pressed("advance_dialog") and scene_name == 'dscene' and ran == false:
		DialogManager.start_dialog(global_position, lines)
		ran=true
#dialog system

func add_health() -> void:
	if alive:
		print("healing")
		if health < 20:
			health += 70.0
		elif health < 50:
			health +=40.0
		elif health < 70:
			health += 20.0
		else:
			health = 100.0
		$healthBar.value = health
