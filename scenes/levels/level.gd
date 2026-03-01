class_name Level
extends Node2D


var tilemap: TileMapLayer
var doors: Array[Door] = []

var active: bool = false


func _init() -> void:
	child_entered_tree.connect( _on_child_entered_tree )
	pass


func _ready() -> void:
	tilemap = $TileMapLayer
	#print(tilemap.get_used_cells_by_id(1))
	pass


func _on_child_entered_tree(child: Node2D):
	if child is Door:
		child.door_used.connect( _on_door_used )
		doors.append(child)


func _on_door_used(door: Door):
	var idx = doors.find(door)
	if doors.size() > idx + 1:
		Game.player.position = doors[idx + 1].position
	else: Game.ui.get_node("%WinScreen").show()


func enable():
	self.show()
	tilemap.enabled = true


func disable():
	self.hide()
	tilemap.enabled = false
