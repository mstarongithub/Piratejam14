extends Node2D

const sector_template = preload("res://templates/map_sector.tscn")
@export_node_path("Camera2D") var camera
var sectors = {}

func get_sector(at: Vector2i) -> Node:
	if not at in sectors:
		sectors[at] = sector_template.instantiate()
	return sectors[at]

func _draw():
	pass
	#for sec

func sectors_in_view() -> Array[Vector2i]:
	var p = camera.position
	var r: Array[Vector2i] = []
	for i in 25:
		r.push_back(Vector2i(fmod(i, 5) - 2, floor(i / 5.0) - 2))
	return r
