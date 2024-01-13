class_name MapSector extends Node2D

#A map sector should be used for things that can change during the game.
#Static things can be a TileMap, TextureRect, etc

const tile_size := 16
const region_size := 16
var tiles: Array[MapTile] = []

func _init():
	tiles.resize(region_size * region_size)
	for i in region_size * region_size:
		tiles[i] = MapTile.new(0)
	#print(tiles)

#func _process(_delta):
#	queue_redraw()

func _draw():
	for i in len(tiles):
		var p = index_to_pos(i)
		#Don't try to draw if we can't because draw_* functions expect a valid call
		if tiles[i].texture() != null:
			draw_texture_rect(tiles[i].texture(), Rect2(p.x, p.y, tile_size, tile_size), true)

func index_to_pos(i: int) -> Vector2:
	return Vector2(	fmod(i, region_size) * tile_size,
					floor(i / region_size) * tile_size)

#This will return a "valid" index even if we're outside the region
func global_tile_to_index(pos: Vector2) -> int:
	var p = pos - (position / tile_size)
	return p.x + p.y * region_size
