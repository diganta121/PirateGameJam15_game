extends Node

@onready var timer = $TabContainer/Potions/Timer

@onready var score_label = %ScoreLabel

var elements={
	"potions":0,
	"gold":0,
	"silver":0
	}

var potionlist={
	"invisibility":0,
	"strength":0,
	"speed":0,
	"enchant":0
	}



func add_point(element):
	elements[element] +=1
	score_label.text = "Items \n potions: {0}    gold: {1}  silver: {2}".format([elements['potions'],elements["gold"],elements['silver']])




func crafter(potion):
	if potion == 'invisibility':
		if elements['potions'] >= 5 and elements['silver'] >= 3:
			potionlist['invisibility'] += 1
			print('Potion crafted')
			
	if potion == 'strength':
		if elements['potions'] >= 5 and elements['gold'] >= 5:
			potionlist['strength'] += 1
			print('Potion crafted')
		else:
			print(%enough)

			
	if potion == 'speed':
		if elements['potions'] >= 10 and elements['gold'] >= 2:
			potionlist['speed'] += 1
			print('Potion crafted')
		else:
			print('not enough elements')
			
	if potion == 'enchant':
		if elements['potions'] >= 5 and elements['silver'] >= 5 and elements['gold'] >= 2:
			potionlist['enchant'] += 1
			print('Potion crafted')
	print(potionlist)

	
