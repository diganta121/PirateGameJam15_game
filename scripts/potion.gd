extends Area2D

@onready var game_manager := get_node("/root/Scene/GameManager")

@export var itemType := 'potions'

func _on_body_entered(body) -> void:
	print(body)
	if body.has_method("player_id"):
		game_manager.add_point(itemType)
		queue_free()
