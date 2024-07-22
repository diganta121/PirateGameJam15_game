extends Node

@onready var PotTimerLabel = $CanvasLayer/PotionTimerLabel
@onready var score_label = get_node("CanvasLayer/ScoreLabel")

@onready var current_scene := $"../TestScene"
@onready var house_scenes := [$"../",$"../"]
@onready var story_scene := $"../"


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
		else:
			$CanvasLayer/esc_menu/AnimationPlayer.play("not_enough")
			
	if potion == 'strength':
		if elements['potions'] >= 5 and elements['gold'] >= 5:
			potionlist['strength'] += 1
			print('Potion crafted')
		else:
			$CanvasLayer/esc_menu/AnimationPlayer.play("not_enough")

			
	if potion == 'speed':
		if elements['potions'] >= 10 and elements['gold'] >= 2:
			potionlist['speed'] += 1
			print('Potion crafted')
		else:
			$CanvasLayer/esc_menu/AnimationPlayer.play("not_enough")
			
	if potion == 'enchant':
		if elements['potions'] >= 5 and elements['silver'] >= 5 and elements['gold'] >= 2:
			potionlist['enchant'] += 1
			print('Potion crafted')
		else:
			$CanvasLayer/esc_menu/AnimationPlayer.play("not_enough")
	print(potionlist)

func not_enough_items():
	%enough.visible = true
	$CanvasLayer/esc_menu/AnimationPlayer.play("not_enough")
