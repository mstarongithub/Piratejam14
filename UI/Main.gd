extends MarginContainer

const ASSETS_INFO = preload("res://UI/AssetsInfo.tscn")
const GAME_SCENE_FRAMEWORK = preload("res://GameSceneFramework.tscn")

func _on_sources_pressed() -> void:
	get_tree().change_scene_to_packed(ASSETS_INFO)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(GAME_SCENE_FRAMEWORK)
