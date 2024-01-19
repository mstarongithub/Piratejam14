extends Control

const MAIN = preload("res://UI/main.tscn")

func _on_return_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN)
