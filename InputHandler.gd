class_name InputHandler extends Node

@onready var caret = get_node("../Caret")
@onready var camera = get_node("../Camera2D")

const speed = 8
var move: Vector2

func global_to_tile(pos: Vector2):
	var scale = ProjectSettings.get_setting("display/window/stretch/scale")
	return floor((pos - (get_viewport().size / 2.0) + camera.position * scale) / (scale * 16.0))

func _process(delta):
	move = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		move += Vector2( 1,  0)
	if Input.is_action_pressed("move_up"):
		move += Vector2( 0, -1)
	if Input.is_action_pressed("move_left"):
		move += Vector2(-1,  0)
	if Input.is_action_pressed("move_down"):
		move += Vector2( 0,  1)
	camera.position += move.normalized() * speed * delta * 60.0
	camera.position = floor(camera.position)

func _unhandled_input(event):
	if  event is InputEventMouseButton and\
		event.button_index == MOUSE_BUTTON_LEFT and\
		event.is_released():
			var sector = get_node("../MapSector")
			var index = sector.global_tile_to_index(global_to_tile(event.global_position))
			sector.tiles[index].content = 75
			print(&"clicked on %s" % global_to_tile(event.global_position))
			print(&"index: %s" % index)
	if event is InputEventMouseMotion:
		caret.position = global_to_tile(event.global_position) * 16.0 + caret.texture.region.size / 2.0
		
