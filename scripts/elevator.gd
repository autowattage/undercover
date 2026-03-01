extends Control
@onready var black_overlay: ColorRect = $"black-overlay"


@onready var last_pos = Vector2(280,20)
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(black_overlay, "modulate:a", 0, 3)
	await tween.tween_property(black_overlay, "modulate:a", 1, 3).finished

	queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if int(round(delta)) % 2 == 0:
			$elevator.position = last_pos + Vector2(randi_range(-8,8), randi_range(-8,8))
	pass
