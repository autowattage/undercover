extends Entity
class_name Enemy


var player_seen = false
var player_in_range = false
var player


func _ready() -> void:
	#body_entered.connect(func(): Game.ui.get_node("%WinScreen").show())
	super()
	Game.player_vented.connect( func():
		player_seen = false
		player_in_range = false )
	Game.player_swapped.connect( func(): if !player_in_range: player_seen = false
	)  # Lose sight if Player swaps out of range.
	$Sight.body_entered.connect( _on_sight_area_body_entered )
	$Sight.body_exited.connect( _on_sight_area_body_exited )


func _physics_process(_delta: float) -> void:
	velocity.y = 980
	if player_seen:
		velocity.x = ((player.position.x - position.x)/abs(player.position.x - position.x)) * 200
		scale.x = -(velocity.x/abs(velocity.x))

	move_and_slide()


func _on_sight_area_body_entered(body):
	if body is PlayerEntity:
		if !Game.hidden:
			player_in_range = true
			player = body
			Game.seen = true
			velocity.x = ((body.position.x - position.x)/abs(body.position.x - position.x)) * 200

func _on_sight_area_body_exited(body):
	if body is PlayerEntity:
		if Game.hidden:
			player_in_range = false
			Game.seen = false
			velocity.x = 0
