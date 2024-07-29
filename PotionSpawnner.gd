extends Area2D
@export var item_type = ""

const ITEMS := {
	"red":"res://scenes/items/red.tscn",
	"blue":"res://scenes/items/blue.tscn",
	"gold":"res://scenes/items/gold.tscn",
	"silver":"res://scenes/items/silver.tscn",
	"strength":"res://scenes/items/strength_potion.tscn",
	"speed": "res://scenes/items/speed_potion.tscn",
	"invisibility": "res://scenes/items/invis_potion.tscn",
	"enchant": "res://scenes/items/healing_potion.tscn",
}

var pre_item_list
var oncooldown := false

# Called when the node enters the scene tree for the first time.
func _ready() ->void:
	pre_item_list["red"] = preload("res://scenes/items/red.tscn")
	pre_item_list["blue"] = preload("res://scenes/items/blue.tscn")
	pre_item_list["gold"] = preload("res://scenes/items/gold.tscn")
	pre_item_list["silver"] = preload("res://scenes/items/silver.tscn")
	pre_item_list["strength"] = preload("res://scenes/items/strength_potion.tscn")
	pre_item_list["speed"] = preload("res://scenes/items/speed_potion.tscn")
	pre_item_list["invisibility"] = preload("res://scenes/items/invis_potion.tscn")
	pre_item_list["enchant"] = preload("res://scenes/items/healing_potion.tscn")
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if not oncooldown:
		spawn_items()
		oncooldown = true

func spawn_items() -> void:
	var spawn_item = pre_item_list["item_type"].instantiate()
	spawn_item.global_position = global_position
	$Marker2D.add_child()
