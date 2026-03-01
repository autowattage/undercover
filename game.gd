extends Node


@warning_ignore_start("unused_signal")
signal player_vented
signal player_swapped
signal door_entered


var ui: CanvasLayer
var level: Level
var sublevel: Level
var player: PlayerEntity

var sublevel_active: bool = false

var hidden = true  # Whether in hidden steath mode
var seen = false
var countdown = 6.0


func _ready() -> void:
	level = get_tree().root.get_node("Node/Level")
	ui = get_tree().root.get_node("Node/UI")
	sublevel = get_tree().root.get_node("Node/SubLevel")
	#sublevel.disable()

	player = get_tree().root.get_node("Node/Level/CombinedRacoon")
	#print(level)

	door_entered.connect( _on_door_entered )

	ui.add_child(preload("res://scenes/intro.tscn").instantiate())
	pass


func _physics_process(delta: float) -> void:
	if seen:
		countdown -= delta
		ui.get_node("%TimerLabel").text = str(int(countdown)) + "!"
	else: ui.get_node("%TimerLabel").hide()
	if countdown <= 0.0:
		ui.get_node("%TimerLabel").text = "CAUGHT!"
		ui.get_node("%LoseScreen").show()
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("swap_character"):
		if !Game.sublevel_active:
			if !hidden:
				hidden = true
				var racoon = preload("res://scenes/entities/player/combined_racoon.tscn").instantiate()
				racoon.position = player.position
				Game.player.queue_free()
				Game.player = racoon
				Game.level.add_child(Game.player)
			else:
				hidden = false
				var racoon = preload("res://scenes/entities/player/racoon_1.tscn").instantiate()
				racoon.position = player.position
				Game.player.queue_free()
				Game.player = racoon
				Game.level.add_child(Game.player)
			self.player_swapped.emit()
			#hidden = !hidden


func _on_door_entered():
	var elevator = preload("res://scenes/elevator.tscn").instantiate()
	ui.get_node("Control").add_child(elevator)

	pass
