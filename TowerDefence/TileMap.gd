extends TileMap

var weights: PackedFloat32Array = []
var dirty = true

func _ready():
	for t in get_used_cells(0):
		weights.push_back(get_cell_tile_data(0, t).get_custom_data(&"weight"))

func _process(_delta):
	if dirty and is_node_ready():
		dirty = false
		var m = get_layer_navigation_map(0)
		var rs = NavigationServer2D.map_get_regions(m)
		for i in len(rs):
			NavigationServer2D.region_set_travel_cost(rs[i], weights[i])
