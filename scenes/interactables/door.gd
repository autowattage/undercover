extends Interactable
class_name Door


signal door_used(door: Door)
#@export var spawnable: bool = false


func _interact():
	print("Door used")
	Game.door_entered.emit()
	door_used.emit(self)

	pass
