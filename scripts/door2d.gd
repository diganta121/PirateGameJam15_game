extends Node2D
var scenechose = 'castle'
@export var go_to := ''
var body_entered
@onready var door = $door


func _on_door_area_entered(area):
	var bodies = door.get_overlapping_bodies()
	print(typeof(bodies))
	for i in bodies:
		if i.has_method("player_id"):
			print("player detected")
			body_entered = true



func _physics_process(delta):
	if body_entered:
		print(1)
		if Input.is_action_just_pressed("use_door"):
			print("check door input")
			if go_to == 'castle':
				get_tree().change_scene_to_file("res://scenes/env/castle.tscn")
			if go_to == 'house':
				get_tree().change_scene_to_file("res://scenes/env/house_inside_1.tscn")
			if go_to == 'small_house':
				get_tree().change_scene_to_file("res://scenes/env/smallhouse.tscn")
			if go_to == 'outside':
				get_tree().change_scene_to_file("res://scenes/env/tester.tscn")
			body_entered = false

func _on_door_body_exited(body):
	print(3)
	body_entered = false
