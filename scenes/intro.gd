extends Control
@onready var black_overlay: ColorRect = $"black-overlay"
@onready var scene: Control = $"scene"
@onready var scene2: Control = $"scene2"


@onready var last_pos = position - Vector2(position.x, position.y/2)
var vshake = false
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(black_overlay, "modulate:a", 0, 3)
	await tween.tween_property(black_overlay, "modulate:a", 1, 1.5).finished
	scene.show()
	var tween2 = get_tree().create_tween()
	await tween2.tween_property(black_overlay, "modulate:a", 0, 1.5).finished


	#tween.tween_callback(func():
	vshake = true
	await get_tree().create_timer(2).timeout

	#await tween.tween_property(scene, "position:y", scene.position.y, 2).finished
	#tween.tween_property(scene, "position:y", scene.position.y + 12, 0.5)
	#tween.tween_property(scene, "position:y", scene.position.y - 12, 0.5)
	#tween.tween_property(scene, "position:y", scene.position.y + 12, 0.5)
	#tween.tween_property(scene, "position:y", scene.position.y - 12, 0.5)
	#tween.tween_property(scene, "position:y", scene.position.y + 12, 0.5)
	#tween.tween_property(scene, "position:y", scene.position.y - 12, 0.5)

	if scene2: scene2.show()
	await get_tree().create_timer(2).timeout
	var tween3 = get_tree().create_tween()
	await tween3.tween_property(black_overlay, "modulate:a", 1, 2).finished

	queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if vshake:
		if int(round(delta)) % 8 == 0:
			if scene:
				scene.position.y = last_pos.y + randi_range(-16,16)
	pass
