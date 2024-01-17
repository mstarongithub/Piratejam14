class_name Effect extends Resource

@export var name: StringName
@export var icon: Texture2D

func _init(name_ = &"", icon_ = null):
	name = name_
	icon = icon_
