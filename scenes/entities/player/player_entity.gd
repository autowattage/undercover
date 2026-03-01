extends Entity
class_name PlayerEntity

#signal item_equipped
signal item_used

const JUMP_VELOCITY = 600.0
#var GRAVITY = 980.0

#var state := State.IDLE
#var action := Action.NONE
#var can_doublejump = true
#var is_in_stealth = false

@export var movement_speed: float = 200.0
@export var equipped_weapon: Weapon
@export var inventory: Array[Weapon] = []

var using_item: bool = false


func _process(_delta: float) -> void:
	aim_item()

	if using_item:
		equipped_weapon.use()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use_character_ability"):
		using_item = true
	if event.is_action_released("use_character_ability"):
		using_item = false

	if event is InputEventKey:
		var key = event.as_text_key_label()
		if key.is_valid_int():
			var inv_idx = int(key)
			if inv_idx > 0 and inv_idx <= inventory.size() and !inventory.is_empty():
				var item = inventory.get(inv_idx - 1)
				equip_item(item)


func _physics_process(delta: float) -> void:
	var xdir = Input.get_axis("move_left", "move_right")
	velocity.x = xdir * movement_speed

	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("run")

	if velocity.x < 0: $AnimatedSprite2D.flip_h = true
	if velocity.x > 0: $AnimatedSprite2D.flip_h = false

	if is_on_floor():
		if xdir: state = State.RUNNING
		else: state = State.IDLE
	else:
		state = State.FALLING
	#else:
		#state = State.JUMPING


	if Game.sublevel_active:
		var ydir = Input.get_axis("move_up", "move_down")
		velocity.y = ydir * movement_speed
	else:
		if Input.is_action_pressed("jump") and (state != State.FALLING): #or can_doublejump):
			velocity.y -= JUMP_VELOCITY
			#velocity.y *= int(self.can_move)  # Ability checks
		self.velocity.y += GRAVITY * delta

	move_and_slide()


#func kill():
	#print(self, " killed.")
	#get_parent().remove_child(self)
	#$Sprite2D.hide()
	#$HitboxComponent.queue_free()
	#$CollisionShape2D.queue_free()
	#self.velocity = Vector2.ZERO

	#if self is Enemy:
		#get_parent().score += 5
	#if self is Player: get_parent().game_loss()
	#else:
	#if DeathParticles:
		#DeathParticles.emitting = true
		#await DeathParticles.finished
	#entity_death.emit( self )
	#queue_free()


#func swap_slots():
	#var new_weapon = secondary_slot
	#secondary_slot = equipped_weapon
	#equipped_weapon = new_weapon
	#secondary_slot.hide()
	#equipped_weapon.show()

func aim_item():
	if equipped_weapon:
		var mouse_pos = get_global_mouse_position()
		var angle = rad_to_deg(get_angle_to(mouse_pos))
		equipped_weapon.rotation_degrees = angle
		#print(rad_to_deg(ang))
		#print(angle)
		#if angle >= 0:
		if angle > -90 or angle < 90:
			$AnimatedSprite2D.flip_h = false
		#if angle <= 0:
		else:
			$AnimatedSprite2D.flip_h = true


func equip_item(item):
	var old_item = equipped_weapon

	# Automatically use the new weapon
	var new_item = item
	equipped_weapon = new_item
	new_item.use()
	item_used.emit(new_item)

	# Swap back to normal weapon
	equipped_weapon = old_item
