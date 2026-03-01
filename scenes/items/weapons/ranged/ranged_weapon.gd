class_name RangedWeapon
extends Weapon


@export var projectile_velocity: float = 600.0
@export var attack_delay: float = 0.0


func _ready() -> void:
	super()
	#pass


func _attack():
	var attack_dir = get_global_mouse_position() - self.global_position
	var projectile = $ProjectileSpawner.spawn()
	#print(projectile)
	projectile.look_at(attack_dir)
	projectile.velocity = attack_dir.normalized() * projectile_velocity
	print(projectile.velocity)
	projectile.position = $ProjectileSpawner.global_position
	projectile.faction = self.user.faction
	#projectile.add_child( $AttackComponent.duplicate() )
	get_parent().get_parent().add_child(projectile)


func _alt_attack():
	pass
