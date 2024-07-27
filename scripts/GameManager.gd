extends Node

@onready var PotTimerLabel := $CanvasLayer/PotionTimerLabel
@onready var score_label := get_node("CanvasLayer/ScoreLabel")

@onready var main_scene := "res://scenes/env/test_scene.tscn"
@onready var house_scenes := ["res://scenes/env/house_inside_1.tscn"]
#@onready var story_scene := $""

@onready var player := get_node("/root/Scene/Player")
@onready var sword := get_node("/root/Scene/Player/sword")

@export var PLAYER_SWORD_DAMAGE := 10
@export var PLAYER_VISIBLE := true
var potion_seconds := 30
var potion_timer := 30

var enemies
var GameState := ""

var elements := {
	"potions":0,
	"gold":0,
	"silver":0
	}

var potionlist := {
	"invisibility":0,
	"strength":0,
	"speed":0,
	"enchant":0
	}
	
var disable_ai := false

func add_point(element) -> void:
	elements[element] +=1
	score_label.text = "Items \n potions: {0}    gold: {1}  silver: {2}".format(
		[elements['potions'],elements["gold"],elements['silver']]
		)

func crafter(potion: String) -> void:
	if potion == 'invisibility':
		if elements['potions'] >= 5 and elements['silver'] >= 3:
			potionlist['invisibility'] += 1
			elements['potions'] -=5
			elements['silver'] -=3
			add_items()
		else:
			not_enough_items()
	if potion == 'strength':
		if elements['potions'] >= 5 and elements['gold'] >= 5:
			potionlist['strength'] += 1
			elements['potions'] -=5
			elements['gold'] -=5
			print('Potion crafted')
			add_items()
		else:
			not_enough_items()

	if potion == 'speed':
		if elements['potions'] >= 10 and elements['gold'] >= 2:
			potionlist['speed'] += 1
			print('Potion crafted')
			elements['potions'] -=10
			elements['gold'] -=2
			add_items()
		else:
			not_enough_items()
			
	if potion == 'enchant':
		if elements['potions'] >= 5 and elements['silver'] >= 5 and elements['gold'] >= 2:
			potionlist['enchant'] += 1
			print('Potion crafted')
			elements['potions'] -=5
			elements['gold'] -=2
			elements['silver'] -=5
			add_items()
		else:
			not_enough_items()
	score_label.text = "Items \n potions: {0}    gold: {1}  silver: {2}".format(
		[elements['potions'],elements["gold"],elements['silver']]
		)
	update_potion_amount()
	print(potionlist)
	
func update_potion_amount() -> void:
	$CanvasLayer/GridContainer/enchant.text =  "enchant" + str(potionlist['enchant'])
	$CanvasLayer/GridContainer/invis.text =  "invisibility" + str(potionlist['invisibility'])
	$CanvasLayer/GridContainer/speed.text =  "speed" + str(potionlist['speed'])
	$CanvasLayer/GridContainer/strength.text =  "strength" + str(potionlist['strength'])

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
		sword.swordState = 1
		sword.enchantEffect()
		start_potion_timer()
	update_potion_amount()

func reset_potion_effects() -> void:
	player.animationState = 1
	PLAYER_SWORD_DAMAGE = 10
	player.speedval = 650
	player.MOB_DAMAGE = 5.0
	PLAYER_VISIBLE = true
	sword.swordState = 0
	update_potion_amount()

func start_potion_timer() -> void:
	potion_timer = potion_seconds
	$CanvasLayer/PotionTimer.start(1)

func _on_potion_timer_timeout() -> void:
	if potion_timer >0:
		potion_timer -= 1
		%PotionTimerLabel.text = "0:" + str(potion_timer)
		$CanvasLayer/PotionTimer.start(1)
		$CanvasLayer/PotionTimer.visible = true
	else:
		$CanvasLayer/esc_menu/AnimationPlayer2.play("timer fade")
		reset_potion_effects()
		$CanvasLayer/PotionTimer.visible = false
	update_potion_amount()
	

