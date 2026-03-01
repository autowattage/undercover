extends Node2D
@onready var black_overlay: ColorRect = $"black-overlay"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween()
	await tween.tween_property(black_overlay, "modulate:a", 0, 4)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
