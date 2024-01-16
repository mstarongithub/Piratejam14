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
	return _towers.reduce(func(acc: Tower, t: Tower):
		if t.global_position.distance_squared_to(pos) < acc.global_position.distance_squared_to(pos):
			return t
		else:
			return acc)
