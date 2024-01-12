class_name InputHandler extends Node

@onready var caret = get_node("../Caret")
@onready var camera = get_node("../Camera2D")

func global_to_tile(pos: Vector2):
	return floor((pos - camera.position - get_viewport().size / (ProjectSettings.get_setting("display/window/stretch/scale") * 2.0)) / 16.0)

func _unhandled_input(event):
	if  event is InputEventMouseButton and\
		event.button_index == MOUSE_BUTTON_LEFT and\
		event.is_released():
			pass
			print(&"clicked on %s" % global_to_tile(event.position))
			print(&"index: %s" % get_node("../Node2D").global_tile_to_index(global_to_tile(event.position)))
	if event is InputEventMouseMotion:
		caret.position = global_to_tile(event.position) * 16.0 + caret.texture.region.size / 2.0
