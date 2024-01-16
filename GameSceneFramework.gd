extends Node2D

func load_game_scene(scene: PackedScene):
	for c in $GameMap.get_children():
		$GameMap.remove_child(c)
	$GameMap.add_child(scene.instantiate())

func load_GUI_scene(scene: PackedScene):
	for c in $GUI.get_children():
		$GUI.remove_child(c)
	$GUI.add_child(scene.instantiate())
