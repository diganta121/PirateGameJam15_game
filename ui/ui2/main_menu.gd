class_name M_Menu
extends Control

@onready var play =$HBoxContainer/play as Button
@onready var qt = $HBoxContainer/qt as Button
@onready var ctrl = $HBoxContainer/ctrl as Button


func _ready():
	play.button_down.connect(_on_play_pressed)
	qt.button_down.connect(on_exit_pressed)
	ctrl.button_down.connect(_on_ctrl_pressed)
	
func on_exit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/player.tscn")


func _on_ctrl_pressed() -> void:
	get_tree().change_scene_to_file("res://ctrl.tscn")

