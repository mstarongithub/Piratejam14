extends Control

enum {
	MadeWithGodot,
	MadeForPirateJam
}

const MAIN = preload("res://UI/main.tscn")

@onready var made_with_godot: VBoxContainer = $PanelContainer/CenterContainer/MadeWithGodot
@onready var for_pirate_jam: VBoxContainer = $PanelContainer/CenterContainer/ForPirateJam

var _state := MadeWithGodot
var _original_scale := 0

func _ready() -> void:
	#_original_scale = get_window().content_scale_stretch
	#scale =  Vector2(1,1) / ProjectSettings.get_setting("display/window/stretch/scale")
	pass

func _process(_delta: float) -> void:
	# Skip preroll
	if Input.is_action_just_pressed("action_confirm") or \
	Input.is_action_just_pressed("action_menu"):
		transition()

func transition() -> void:
	match _state:
		MadeWithGodot:
			_state = MadeForPirateJam
			made_with_godot.visible = false
			for_pirate_jam.visible = true
		MadeForPirateJam:
			get_window().content_scale_aspect = _original_scale
			get_tree().change_scene_to_packed(MAIN)
