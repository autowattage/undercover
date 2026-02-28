extends Interactable
class_name Vent


func _interact():
	#print("vent used")
	print(get_parent())

	if Game.sublevel_active:
		Game.player.reparent( Game.level)
		Game.sublevel_active = false
		Game.level.enable()
		Game.sublevel.disable()
	else:
		Game.player.reparent( Game.sublevel)
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
