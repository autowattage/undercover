extends CharacterBody2D
class_name Entity

signal entity_death
#signal entity_created
#signal entity_projectile_created

enum Factions {
	#FACTION_NONE,
	FACTION_NEUTRAL,
	FACTION_ALLY,
	FACTION_ENEMY,
}

enum State {
	IDLE, RUNNING, JUMPING, FALLING,
}
enum Action {
	NONE,
	HIDING,
	STEALTH_ATTACK,
	JUMP_ATTACK,
}

var state := State.IDLE
var action := Action.NONE

## Damage dealt to incomming projectile on contact
#@export var projectile_damage = 1

@export var faction: Factions = Factions.FACTION_NEUTRAL

@export var DamageParticles = preload("res://scenes/particles/blood.tscn")
@export var DeathParticles = preload("res://scenes/particles/blood.tscn")

#@export_group("Targets")
#@export var targets_player: bool = true
#@export var TargetComp: TargetingComponent
#@export var entity_targets: Array[Entity]
#@export var faction_targets: Array[Entity]

@export_group("Traits")
@export var damageable: bool = true
@export var healable: bool = true
@export var killable: bool = true
#@export var imunities

var HitboxComp: HitboxComponent
var HealthComp: HealthComponent
var AttackComp: AttackComponent
#var MovementComp: MovementComponent


func _ready() -> void:
	setup()


## Initialize and checks for entity components.
func setup():
	if has_node("HitboxComponent"): HitboxComp = $HitboxComponent
	if has_node("HealthComponent"): HealthComp = $HealthComponent
	if has_node("AttackComponent"): AttackComp = $AttackComponent
	#if has_node("MovementComponent"): MovementComp = $MovementComponent

	if HitboxComp:
		HitboxComp.hit.connect( _on_hitbox_hit )
	if HealthComp:
		HealthComp.health_damaged.connect( _on_health_damaged )
		HealthComp.health_zero.connect( _on_health_zero )
	# if AttackComp:
	# 	AttackComp
	#if MovementComp:
		#MovementComp

	if DamageParticles:
		DamageParticles = DamageParticles.instantiate()
		add_child(DamageParticles)
	if DeathParticles:
		DeathParticles = DeathParticles.instantiate()
		add_child(DeathParticles)

	add_to_group( get_faction() )
	add_to_group("entities")


func _on_hitbox_hit(damage: Damage):
	if damageable:
		HealthComp.apply_damage(damage)
	else: print(self, " is immune.")


# Damage effects
func _on_health_damaged(amount):
	if DamageParticles: DamageParticles.emitting = true

	var t = create_tween()
	t.tween_property(self, "modulate", Color(1, 0, 0), 0.1)
	t.tween_property(self, "modulate", Color(1, 1, 1), 0.1)
	#print(self)
	#if self is not Player:
	#get_parent().add_child( DamageNumber.new(self.position, amount) )  # Damage numbers


func _on_health_zero():
	if killable:
		kill()
	else: print(self, " is immortal.")


# Corpse, death effects, deletion
func kill():
	#print(self, " killed.")
	if has_node("Sprite2D"): $Sprite2D.hide()
	if has_node("HitboxComponent"): $HitboxComponent.queue_free()
	if has_node("CollisionShape2D"): $CollisionShape2D.queue_free()
	self.velocity = Vector2.ZERO

	#if self is Player: get_parent().game_loss()
	entity_death.emit( self )
	if DeathParticles:
		DeathParticles.emitting = true
		await DeathParticles.finished
	queue_free()


func get_health():
	if HealthComp: return HealthComp.health


func get_damage():
	if AttackComp: return AttackComp.DamageComp


func get_faction():
	if faction == Factions.FACTION_NEUTRAL: return "FactionNeutral"
	if faction == Factions.FACTION_ALLY: return "FactionAlly"
	if faction == Factions.FACTION_ENEMY: return "FactionEnemy"


#func get_target(_target_filter):
	#pass
