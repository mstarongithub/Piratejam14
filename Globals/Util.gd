@tool
extends Node

## Snaps the given node to the center of the closest tile on a tilemap in editor
## Note: Currently only searches the topmost layer of the currently open scene (all the children of the root node)
func snap_to_tilemap(node_to_snap: Node2D) -> void:
	var tilemap: TileMap
	for child in EditorInterface.get_edited_scene_root().get_children():
		if child is TileMap:
			tilemap = child as TileMap
			break
	# TODO: Optionally add deep search
	if not tilemap:
		return
	# And then convert it back to global and set own global to that
	node_to_snap.global_position = tilemap.to_global(
		# Turn that into local space to center
		tilemap.map_to_local(
			# Then get the map tile position
			tilemap.local_to_map(
				# Turn it into a local position for the tilemap
				tilemap.to_local(
					# Take own global positon
					node_to_snap.global_position
	))))

func find_region_at(map: RID, pos):
	if map != null and map.get_id() != 0:
		var regs = NavigationServer2D.map_get_regions(map)
		for reg in regs:
			if NavigationServer2D.region_owns_point(reg, pos):
				return reg
