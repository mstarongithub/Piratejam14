extends TileMap

var weights: PackedFloat32Array
var dirty = true

func _ready():
	var coords = get_used_cells(0)
	weights.resize(coords.size())
	for index in coords.size():
		#var index = c.x + c.y * 16# assuming it's 16 wide here!
		weights[index] = 0.0
		for l in get_layers_count():
			var d = get_cell_tile_data(l, coords[index])
			weights[index] += d.get_custom_data(&"weight") if d != null else 0.0

func _process(_delta):
	if dirty and is_node_ready():
		dirty = false
		var m := get_layer_navigation_map(0)
		var rs := NavigationServer2D.map_get_regions(m)
		for i in len(rs):
			NavigationServer2D.region_set_travel_cost(rs[i], weights[i])

var valid_tiles = [
	Vector2i(0, 0),
	Vector2i(1, 0),
	Vector2i(2, 0),
	Vector2i(3, 0),
	Vector2i(0, 1),
	Vector2i(1, 1),
	Vector2i(2, 1),
	Vector2i(3, 1),
	Vector2i(0, 2),
	Vector2i(1, 2),
	Vector2i(2, 2),
	Vector2i(3, 2),
	Vector2i(0, 3),
	Vector2i(1, 3),
	Vector2i(2, 3),
	Vector2i(3, 3),
	Vector2i(0, 4),
	Vector2i(1, 4),
	Vector2i(2, 4),
	Vector2i(3, 4),
	Vector2i(0, 5),
	Vector2i(1, 5),
	Vector2i(2, 5),
	Vector2i(3, 5),
]
func try_place_road(pos: Vector2):
	var ct = get_cell_atlas_coords(0, pos)
	var alt = get_cell_alternative_tile(0, pos)
	print(alt)
	if ct in valid_tiles and alt == 0:
		if ct.y > 2:
			set_cell(0, pos, 0, Vector2(1, 0))
		set_cells_terrain_connect(1, [pos], 0, 0)

