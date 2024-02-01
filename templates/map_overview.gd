extends Node2D

const _starton	= preload("res://TowerDefence/Starton.tscn")
const _plains	= preload("res://TowerDefence/RandSectors/PlainPlains.tscn")
const _forest	= preload("res://TowerDefence/RandSectors/FoliageForest.tscn")
const _desert	= preload("res://TowerDefence/RandSectors/DryDesert.tscn")

#const sector_template = preload("res://templates/map_sector.tscn")
#@export_node_path("Camera2D") var camera
@onready var camera = get_node("/root/GameSceneFramework/Camera2D")
var sectors = {}

func _ready():
	sectors[Vector2i(0, 0)] = _starton.instantiate()
	add_child(sectors[Vector2i(0, 0)])
	

func random_sector() -> Node:
	return [_plains, _forest, _desert].pick_random().instantiate()

func get_sector(at: Vector2i) -> Node:
	if not at in sectors:
		sectors[at] = random_sector()
		sectors[at].position = at * 256
		#prints(at, sectors[at].position)
		add_child(sectors[at])
	return sectors[at]

func _process(_delta):
	if is_node_ready():
		for s in sectors_in_view():
			get_sector(s)

func sectors_in_view() -> Array[Vector2i]:
	var p = floor(camera.position / get_parent().scale / 256.0)
	var r: Array[Vector2i] = []
	for i in 25:
		r.push_back(Vector2i(fmod(i, 5) - 2 + p.x, floor(i / 5.0) - 2 + p.y))
	return r

