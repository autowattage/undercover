extends Node


var level: Level
var sublevel: Level
var player: PlayerEntity

var spawn_point: Door

var sublevel_active: bool = false


func _ready() -> void:
	level = get_tree().root.get_node("Node/Level")
	sublevel = get_tree().root.get_node("Node/SubLevel")
	#sublevel.disable()

	player = get_tree().root.get_node("Node/Level/CombinedRacoon")
	print(level)
	pass
