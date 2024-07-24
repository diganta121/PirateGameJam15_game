extends Node

@onready var PotTimerLabel = $CanvasLayer/PotionTimerLabel
@onready var score_label = get_node("CanvasLayer/ScoreLabel")

@onready var main_scene := "res://scenes/env/test_scene.tscn"
@onready var house_scenes := ["res://scenes/env/house_inside_1.tscn"]
@onready var story_scene := $""

@export var PLAYER_SWORD_DAMAGE = 10

var GameState = ""

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
		else:
			not_enough_items()
			
	if potion == 'strength':
		if elements['potions'] >= 5 and elements['gold'] >= 5:
			potionlist['strength'] += 1
			elements['potions'] -=5
			elements['gold'] -=5
			print('Potion crafted')
		else:
			not_enough_items()

			
	if potion == 'speed':
		if elements['potions'] >= 10 and elements['gold'] >= 2:
			potionlist['speed'] += 1
			print('Potion crafted')
			elements['potions'] -=10
			elements['gold'] -=2
		else:
			not_enough_items()
			
	if potion == 'enchant':
		if elements['potions'] >= 5 and elements['silver'] >= 5 and elements['gold'] >= 2:
			potionlist['enchant'] += 1
			print('Potion crafted')
			elements['potions'] -=5
			elements['gold'] -=2
			elements['silver'] -=5
		else:
			not_enough_items()
	print(potionlist)
	

<<<<<<< Updated upstream
func not_enough_items() -> void:
	%enough.visible = true
	$CanvasLayer/esc_menu/AnimationPlayer.play("not_enough")


func use_potion():
	
	pass
=======
func _on_strength_pressed() -> void:
	if potionlist['strength'] >0:
		potionlist['strength'] -= 1
		print(potionlist)
		get_node("/root/Scene/Player").aniplay()

func _on_speed_pressed():
	if potionlist['speed'] >0:
		potionlist['speed'] -= 1
		print(potionlist)
		get_node("/root/Scene/Player").speedplay()
>>>>>>> Stashed changes
