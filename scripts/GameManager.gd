extends Node

@onready var PotTimerLabel := $CanvasLayer/PotionTimerLabel

@onready var score_label := get_node("CanvasLayer/ScoreLabel")
@onready var player := get_node("/root/Scene/Player")
@onready var sword := get_node("/root/Scene/Player/sword")

@export var PLAYER_SWORD_DAMAGE :int= 20
@export var PLAYER_VISIBLE :bool= true
var potion_seconds :int= 30
var potion_timer :int= 30

var enemies
var GameState := ""

var elements := {
	"red":0,
	"blue":0,
	"gold":0,
	"silver":0,
	}

var potionlist := {
	"invisibility":0,
	"strength":0,
	"speed":0,
	"enchant":0,
	}
	
var disable_ai := false

func add_point(element:String) -> void:
	if element in elements.keys():
		elements[element] +=1
		score_label.text = "Items \n red: {0} blue {1} gold: {2} silver: {3}".format(
			[elements['red'],elements['blue'],elements["gold"],elements['silver']]
			)
	elif element in potionlist.keys():
		potionlist[element] +=1
		update_potion_amount()

func crafter(potion: String) -> void:
	if potion == 'invisibility':
		if elements['red'] >= 4 and elements['gold'] >= 5:
			potionlist['invisibility'] += 1
			elements['red'] -=4
			elements['gold'] -=5
			add_items()
		else:
			not_enough_items()
	if potion == 'strength':
		if elements['red'] >= 3 and elements['silver'] >= 3:
			potionlist['strength'] += 1
			elements['red'] -=3
			elements['silver'] -= 3
			print('Potion crafted')
			add_items()
		else:
			not_enough_items()

	if potion == 'speed':
		if elements['blue'] >= 2 and elements['gold'] >= 1:
			potionlist['speed'] += 1
			print('Potion crafted')
			elements['blue'] -= 2
			elements['gold'] -= 1
			add_items()
		else:
			not_enough_items()
			
	if potion == 'enchant':
		if elements['red'] >= 1 and elements['blue'] >= 1 and elements['gold'] >= 2:
			potionlist['enchant'] += 1
			print('Potion crafted')
			elements['red'] -=1
			elements['blue'] -=1
			add_items()
		else:
			not_enough_items()
	score_label.text = "Items \n red: {0} blue {1} gold: {2} silver: {3}".format(
			[elements['red'],elements['blue'],elements["gold"],elements['silver']]
			)
	update_potion_amount()
	print(potionlist)
	
func update_potion_amount() -> void:
	$CanvasLayer/GridContainer/enchant.text =  "healing " + str(potionlist['enchant'])
	$CanvasLayer/GridContainer/invis.text =  "invisibility " + str(potionlist['invisibility'])
	$CanvasLayer/GridContainer/speed.text =  "speed " + str(potionlist['speed'])
	$CanvasLayer/GridContainer/strength.text =  "strength " + str(potionlist['strength'])

func not_enough_items() -> void:
	%enough.visible = true
	$CanvasLayer/esc_menu/AnimationPlayer.play("not_enough")

func add_items() -> void:
	%enough.visible = true
	$CanvasLayer/esc_menu/AnimationPlayer2.play("item_add")
#1:'walk',
#2:'strength',
#3:'speed'

func _on_strength_pressed() -> void:
	if potionlist['strength'] >0:
		potionlist['strength'] -= 1
		player.animationState = 2
		PLAYER_SWORD_DAMAGE = 35
		start_potion_timer()
	update_potion_amount()

func _on_speed_pressed() -> void:
	if potionlist['speed'] >0:
		potionlist['speed'] -= 1
		player.speedplay()
		start_potion_timer()
	update_potion_amount()
	
func _on_invis_pressed() -> void:
	if potionlist['invisibility'] >0:
		potionlist['invisibility'] -= 1
		PLAYER_VISIBLE = false
		start_potion_timer()
	update_potion_amount()

func _on_enchant_pressed() -> void:
	if potionlist['enchant'] >0:
		potionlist['enchant'] -= 1
		player.add_health()
	update_potion_amount()

func reset_potion_effects() -> void:
	PLAYER_SWORD_DAMAGE = 20
	PLAYER_VISIBLE = true
	player.reset_potions()
	sword.reset_potions()
	update_potion_amount()

func start_potion_timer() -> void:
	%PotionTimerLabel.show()
	potion_timer = potion_seconds
	$CanvasLayer/PotionTimer.start(1)

func _on_potion_timer_timeout() -> void:
	if potion_timer >0:
		potion_timer -= 1
		%PotionTimerLabel.text = "0:" + str(potion_timer)
		$CanvasLayer/PotionTimer.start(1)
	else:
		$CanvasLayer/esc_menu/AnimationPlayer2.play("timer fade")
		%PotionTimerLabel.hide()
		reset_potion_effects()
	update_potion_amount()
	
func _on_give_up_pressed():
	get_tree().paused = false
	get_tree().quit()

func _on_retry_pressed():
	$CanvasLayer/dead_screen.hide()
	get_tree().paused = false
	get_tree().reload_current_scene()
	player.health = 100
	player.unalive()
	
func _on_dark_boss_bosss_dead():
	$CanvasLayer/won.show()
	$"game over timer".start(30)

func _on_player_player_dead():
	player.unalive()
	$CanvasLayer/dead_screen.show()
	get_tree().paused = true

func _on_game_over_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/scene.tscn")
