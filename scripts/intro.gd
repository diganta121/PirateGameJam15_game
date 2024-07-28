extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var game = preload("res://scenes/scene.tscn")
func _on_video_stream_player_finished():
	get_tree().change_scene_to_packed(game)
func _unhandled_input(event):
	if Input.is_action_just_pressed("advance_dialog"):
		get_tree().change_scene_to_packed(game)
		
