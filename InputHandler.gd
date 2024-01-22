class_name InputHandler extends Node

@onready var caret = get_node("../GameMap/Caret")
@onready var camera = get_node("../Camera2D")
@onready var gamearea = get_node("../GameMap")

const speed = 8
var move: Vector2
var dragging := false

func global_to_tile(pos: Vector2):
	var scale = ProjectSettings.get_setting("display/window/stretch/scale") * gamearea.scale
	#      ↓int   ↓global position - ↓half the view + ↓scaled camera position    / ↓scaled tile size
	return Vector2i(floor((pos - (get_viewport().size / 2.0) + camera.position) / (scale * 16.0)))

func _process(delta):
	#Handling wasd movement here because we need the continuous state, not just the events, and also the delta
	#The speed is not the actual camera speed as it will smooth to a max of 8px/s configurable on the camera node
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
	#Avoid stopping at sub-pixel even tho we render with nearest in case we don't do that later
	camera.position = floor(camera.position)

func _unhandled_input(event):
	if  event is InputEventMouseButton and\
		event.button_index == MOUSE_BUTTON_LEFT and\
		event.is_released():
			print(&"clicked on %s" % global_to_tile(event.global_position))
			for c in gamearea.get_children():
				if c.name != &"Caret":
					c.get_node("TileMap").try_place_road(global_to_tile(event.global_position))
	if  event is InputEventMouseButton and\
		event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_pressed():
				dragging = true
			if event.is_released():
				dragging = false
	if event is InputEventMouseMotion:
		if dragging:
			camera.position -= event.relative
		caret.position = global_to_tile(event.global_position) * 16.0 + caret.texture.region.size / 2.0
		for c in gamearea.get_children():
			if c.name !="Caret":
				if c.is_node_ready() and global_to_tile(event.global_position) in c.get_node("TileMap").costs:
					caret.get_node("debugtxt").text = &"travel cost: %s" % c.get_node("TileMap").costs[global_to_tile(event.global_position)].cost
				else:
					caret.get_node("debugtxt").text = &""
	if  event is InputEventMouseButton and\
		event.is_action("zoom_in"):
			var s = gamearea.scale
			gamearea.scale += Vector2(0.1, 0.1)
			camera.position = camera.position * gamearea.scale / s
	if  event is InputEventMouseButton and\
		event.is_action("zoom_out"):
			var s = gamearea.scale
			gamearea.scale -= Vector2(0.1, 0.1)
			camera.position = camera.position * gamearea.scale / s
