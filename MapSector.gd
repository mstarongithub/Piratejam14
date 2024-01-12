class_name MapSector extends Node

const size := 16
var tiles = []

func _init():
	for i in size * size:
		tiles[i] = MapTile.new()
