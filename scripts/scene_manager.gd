class_name SceneManager extends Node
var player: Player 

# Called when the node enters the scene tree for the first time.
func change_scene(from,to_scene_name: String) -> void:
	player = from.get_node("player")
	player.get_parent().remove_child(player)
	
	if to_scene_name== 'castle':
		get_tree().call_deferred("change_scene_to_file","res://scenes/env/castle.tscn")
	if to_scene_name== 'outside':
		get_tree().call_deferred("change_scene_to_file","res://scenes/env/tester.tscn")
	if to_scene_name== 'smallhouse':
		get_tree().call_deferred("change_scene_to_file","res://scenes/env/smallhouse.tscn")
	if to_scene_name== 'house':
		get_tree().call_deferred("change_scene_to_file","res://scenes/env/house_inside_1.tscn")
