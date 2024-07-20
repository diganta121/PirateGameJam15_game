extends Node


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed('ui_cancel'):
		print_tree()
		print_stack()
		#$CanvasLayer/Label
