class_name AttackComponent
extends Node


## Base damage comp which defines default attack damage.
#@export var DamageComp: Damage

@export var damage: int = 1
#@export var body_damage: int
@export var projectile_damage: int = 1

## Modifiers which alter stats of default damage comp depending on current action/state.
#@export var attacks: Dictionary[String, Damage] = {}
#@export var AttackMods: Dictionary = {}


# Returns modified DamageComp based on current action/state
#func get_action_modifier(_action):
	#return DamageComp
