extends Node2D
#extends Area2D
class_name Item


var user: Entity
@export var icon: Texture2D


func _ready() -> void:
	user = get_parent()


#func _
