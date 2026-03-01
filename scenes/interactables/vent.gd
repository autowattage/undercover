extends Interactable
class_name Vent


func _interact():
	#print("vent used")
	print(get_parent())

	if Game.sublevel_active:
		#Game.player.reparent( Game.level)
		var racoon = preload("res://scenes/entities/player/combined_racoon.tscn").instantiate()
		Game.player.queue_free()
		Game.player = racoon
		Game.level.add_child(Game.player)

		Game.sublevel_active = false
		Game.level.enable()
		Game.sublevel.disable()
	else:
		var racoon = preload("res://scenes/entities/player/racoon_1.tscn").instantiate()
		Game.player.queue_free()
		Game.player = racoon
		Game.sublevel.add_child(Game.player)
		#Game.player.reparent( Game.sublevel)
		Game.sublevel_active = true
		Game.sublevel.enable()
		Game.level.disable()
	Game.player.position = self.position

	#var tilemap_coord = Game.level.tilemap.get_coords_for_body_rid( get_rid() )
	#Game.player.posi
	#var tilemap_coord = Game.level.tilemap.get_used_cells_by_id()
	#print(get_rid())
	#Game.player.position = Game.sublevel.get_node( self.get_index())
	pass
