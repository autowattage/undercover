extends Entity


var player

#func _ready() -> void:
	#super()


func _physics_process(_delta: float) -> void:
	#velocity.y = 980
	if player:
		velocity.x = ((player.position.x - position.x)/abs(player.position.x - position.x)) * 300
	#preload("res://scenes/entities/projectiles/projectile.tscn").instantiate()

	move_and_slide()


func _on_sight_area_body_entered(body):
	if body is PlayerEntity:
		#if !Game.hidden:
		player = body
		Game.seen = true
		velocity.x = ((body.position.x - position.x)/abs(body.position.x - position.x)) * 300

func _on_sight_area_body_exited(body):
	if body is PlayerEntity:
		print("Asjnkd")
		spawn_bullet()
		#if !Game.hidden:
		#Game.seen = false
		#hide()
		pass


func spawn_bullet():
	var projectile = preload("res://scenes/entities/projectiles/projectile.tscn").instantidaate()
	projectile.position = self.position
	Game.level.add_child(projectile)
	projectile.velocity = (player.position - projectile.position).normalized() * 500
	pass
