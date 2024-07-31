extends Node2D

@onready var button = $Button
@onready var menu=preload("res://m_menu.tscn") as PackedScene
func _ready():
	button.button_down.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(menu)

