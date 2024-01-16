extends PanelContainer

@onready var _icon: TextureRect = find_child(&"icon")
@onready var _text: Label = find_child(&"name")

var icon:
	set(v):
		_icon.texture = v

var text:
	set(v):
		_text.text = v

var type
