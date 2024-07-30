extends Node2D
@export var go_to := ''
var entered = false
@onready var door = $door

func _on_door_body_entered(body):
	entered = true

func _on_door_body_exited(body):
	entered = false

func _physics_process(delta):
	if entered == true:
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
				print('cas')
				get_tree().change_scene_to_file("res://scenes/env/castle.tscn")
			elif go_to == 'house':
				get_tree().change_scene_to_file("res://scenes/env/house_inside_1.tscn")
			elif go_to == 'small':
				print('smallll')
				get_tree().change_scene_to_file("res://scenes/env/smallhouse.tscn")
			elif go_to == 'outside':
				get_tree().change_scene_to_file("res://scenes/env/tester.tscn")
			elif go_to == 'play':
				get_tree().change_scene_to_file("res://scenes/scene.tscn")








