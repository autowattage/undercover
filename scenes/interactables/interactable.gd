class_name Interactable
extends Area2D


var user: Entity
var interactable: bool = false


func _init() -> void:
	body_entered.connect( _on_body_entered )
	body_exited.connect( _on_body_exited )
	pass


func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("interact"):
	if interactable:
		if Input.is_action_just_released("interact"):
			_interact()
		#$Label.text = "interact [E]"
		#if Input.is_action_just_pressed("interact"):
			#self.interact()
	#else:
		#$Label.text = ""
	pass


func _on_body_entered(body: Node2D) -> void:
	#user = body
	if body is PlayerEntity: interactable = true


func _on_body_exited(body: Node2D) -> void:
	if body is PlayerEntity: interactable = false


func _interact():
	# DO interaction effects
	pass
