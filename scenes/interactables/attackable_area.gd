extends Interactable
class_name AttackableArea


#signal door_used(door: Door)
#@export var spawnable: bool = false


func _interact():
	get_parent().kill()
	pass
