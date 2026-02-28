extends Interactable
class_name Door


signal door_used(door: Door)
#@export var spawnable: bool = false


func _interact():
	print("Door used")
	door_used.emit(self)
	pass
