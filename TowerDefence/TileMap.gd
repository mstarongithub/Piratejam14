extends TileMap

@onready var undiscovered_fog = get_node("UndiscoveredFog")
var costs = {}
var dirty = true

func _process(_delta):
	if dirty and is_node_ready():
		dirty = false
		var coords = get_used_cells(0)
		var map := get_layer_navigation_map(0)
		for index in coords.size(): 
			#var region = Util.find_region_at(map, coords[index] * 16.0)
			var c = Vector2i(coords[index])
			var x = c.x * 16.0
			var y = c.y * 16.0
			var region := NavigationServer2D.region_create()
			var polygon := NavigationPolygon.new()
			polygon.vertices = PackedVector2Array([
				Vector2(x,			y) + global_position,
				Vector2(x + 16.0,	y) + global_position,
				Vector2(x + 16.0,	y + 16.0) + global_position,
				Vector2(x, 			y + 16.0) + global_position])
			polygon.add_polygon([0, 1, 2, 3])
			NavigationServer2D.region_set_map(region, map)
			NavigationServer2D.region_set_navigation_polygon(region, polygon)
			costs[c] = {&"RID": region, &"cost": 1.0}
			for l in get_layers_count():
				var d = get_cell_tile_data(l, c)
				costs[c].cost += d.get_custom_data(&"cost") if d != null else 0.0
		for wd in costs.values():
			NavigationServer2D.region_set_travel_cost(wd.RID, wd.cost)

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
func try_place_road(pos: Vector2i):
	var ct = get_cell_atlas_coords(0, pos)
	var alt = get_cell_alternative_tile(0, pos)
	#print(alt)
	if	ct in valid_tiles and alt == 0 and\
		get_cell_atlas_coords(1, pos) == Vector2i(-1, -1) and\
		get_cell_atlas_coords(2, pos) == Vector2i(-1, -1):
		if ct.y > 2:
			set_cell(0, pos, 0, Vector2(1, 0))
		set_cells_terrain_connect(1, [pos], 0, 0)
		costs[pos].cost = 20.0
		var cost_data = costs[pos]
		NavigationServer2D.region_set_travel_cost(cost_data.RID, cost_data.cost)
