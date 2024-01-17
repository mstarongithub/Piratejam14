extends PanelContainer

@onready var _icon: TextureRect = find_child(&"icon")
@onready var _text: Label = find_child(&"name")
@export var type: Card

var icon:
	set(v):
		_icon.texture = v

var text:
	set(v):
		_text.text = v

func _ready():
	if type == null:
		push_warning(&"Card %s has no type" % self)
	if type != null:
		icon = type.effect.icon
		text = &"%s x%s" % [type.effect.name, type.amount]
