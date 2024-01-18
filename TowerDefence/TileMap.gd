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
