class_name MapTile extends Node

var content

func _init(c := 0):
	content = c

func texture():
	return Patron.sprites[content] if content < len(Patron.sprites) else null

func _to_string():
	return &"MapTile %s" % content
