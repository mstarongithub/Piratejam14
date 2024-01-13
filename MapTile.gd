class_name MapTile extends Node

var content: int

func _init(c := -1):
	content = c

func is_empty():
	return content == -1

func texture():
	if is_empty() or content > len(Patron.sprites):
		return null
	return Patron.sprites[content]

func _to_string():
	return &"MapTile %s" % content
