class_name MapSector extends CanvasItem

const tile_size := 16
const region_size := 32
var tiles = []

func _init():
	tiles.resize(region_size * region_size)
	for i in region_size * region_size:
		tiles[i] = MapTile.new()
	#print(tiles)

func _process(delta):
	queue_redraw()

func _draw():
	for i in len(tiles):
		var x = fmod(i, region_size) * tile_size
		var y = floor(i / region_size) * tile_size
		#printt(i, x, y)
		if tiles[i].texture() != null:
			draw_texture_rect(tiles[i].texture(), Rect2(x, y, tile_size, tile_size), true)
