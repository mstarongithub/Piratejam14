extends Node

var _towers: Array[Tower]

func register_tower(t: Tower) -> void:
	_towers.append(t)

func remove_tower(t: Tower) -> void:
	var pos := _towers.find(t)
	if pos >= 0:
		_towers.remove_at(pos)

## Returns the tower closest to the given global position
func get_tower_closest_to(pos: Vector2) -> Tower:
	var distance := 999**2 # Should be big enough
	var closest: Tower = null
	for i in _towers:
		if i.global_position.distance_squared_to(pos) < distance:
			distance = i.global_position.distance_squared_to(pos)
			closest = i
	return closest
