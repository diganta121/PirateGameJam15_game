extends CharacterBody2D
var health := 100.0
const DAMAGE := 5.0
signal player_dead

func _physics_process(delta:float) -> void:
	var direc = Input.get_vector(
		"move_left","move_right","move_up","move_down"
		)
	velocity = direc * 650 
	move_and_slide()
	#if velocity.length() > 0.0:
		#get_node("CollisionShape2D/HappyBoo").play_walk_animation()
	#else :
		#get_node("CollisionShape2D/HappyBoo").play_idle_animation()
	var over_mobs = %HurtBox.get_overlapping_bodies()
	if over_mobs.size() >0 :
		health -= DAMAGE * delta
		if health <= 0.0:
			player_dead.emit()

func player_id() -> int:
	return 1

func potion_strength() -> void:
	
	pass

