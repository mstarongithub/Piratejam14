class_name Patron extends RefCounted

static var sprites: Array[AtlasTexture] = []

static func _static_init():
	var atlas_tex = preload("res://Assets/RTS Medieval (Pixel)/tilemap_packed.png")
	var TILE_SIZE = 16
	var s = atlas_tex.get_size() / TILE_SIZE
	sprites.resize(s.x * s.y)
	for i in s.x * s.y:
		sprites[i] = AtlasTexture.new()
		sprites[i].atlas = atlas_tex
		sprites[i].region = Rect2(fmod(i, s.x) * TILE_SIZE, floor(i / s.x) * TILE_SIZE, TILE_SIZE, TILE_SIZE)
	print(&"Sprites: %s" % len(sprites))
