extends Area2D
@export var item_type = "red"

var oncooldown := false
var d

# Called when the node enters the scene tree for the first time.
func _ready() ->void:
	d = {
		'red':red_spawner,
		'blue':blue_spawner,
		'gold':gold_spawner,
		'silver':silver_spawner,
		'speed':speed_pot_spawner,
		'healing':heal_pot_spawner,
		'invis':invis_pot_spawner,
		'strength':str_pot_spawner,
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if not oncooldown:
		spawn_items()
		$Timer.start(25 + randi_range(-10,10))
		oncooldown = true

func spawn_items() -> void:
	print("spawning item")
	var spawn_item = (d[item_type].call()).instantiate()
	spawn_item.global_position = global_position
	$Marker2D.add_child(spawn_item)

func red_spawner()->PackedScene:
	return preload("res://scenes/items/red.tscn")

func blue_spawner()->PackedScene:
	return preload("res://scenes/items/blue.tscn")
	
func heal_pot_spawner()->PackedScene:
	return preload("res://scenes/items/healing_potion.tscn")
	
func str_pot_spawner()->PackedScene:
	return preload("res://scenes/items/strength_potion.tscn")

func speed_pot_spawner()->PackedScene:
	return preload("res://scenes/items/speed_potion.tscn")

func invis_pot_spawner()->PackedScene:
	return preload("res://scenes/items/invis_potion.tscn")

func gold_spawner()->PackedScene:
	return preload("res://scenes/items/gold.tscn")

func silver_spawner()->PackedScene:
	return preload("res://scenes/items/silver.tscn")


func _on_timer_timeout():
	oncooldown = false
