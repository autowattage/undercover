extends Entity
class_name Enemy


func _ready() -> void:
	$Sight.body_entered.connect( _on_sight_area_body_entered )
	pass


func _physics_process(delta: float) -> void:
	velocity.y = 980

	move_and_slide()


func _on_sight_area_body_entered(body):
#	if body is PlayerEntity and Game.
	pass
