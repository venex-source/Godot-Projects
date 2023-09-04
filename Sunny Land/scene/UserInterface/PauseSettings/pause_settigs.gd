extends Control

signal resume_game

@onready var scene_tree = get_tree()

func _on_back_button_pressed():
	hide()
	emit_signal("resume_game")

func _on_retry_button_pressed():
	if scene_tree.paused:
		scene_tree.paused = false
	scene_tree.reload_current_scene()

func _on_home_button_pressed():
	scene_tree.change_scene_to_file("res://scene/Screens/mainscreen.tscn")

func _on_settings_button_pressed():
	SceneManager.show_open_settings()
