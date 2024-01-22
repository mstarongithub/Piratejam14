extends MarginContainer

const SOURCES = preload("res://UI/Sources.tscn")
const GAME_SCENE_FRAMEWORK = preload("res://GameSceneFramework.tscn")

func _on_sources_pressed() -> void:
	get_tree().change_scene_to_packed(SOURCES)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(GAME_SCENE_FRAMEWORK)

func quit():
	get_tree().quit()
