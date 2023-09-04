extends HBoxContainer

@onready var fader = $"%Fader"

func _on_play_pressed():
	Event.select_level = true
	get_tree().change_scene_to_file("res://scene/UserInterface/Level_Menu_UI/level_menu.tscn")

func _on_exit_button_pressed():
	fader.fade_screen(true, get_tree().quit)

func _on_options_pressed():
	SceneManager.show_open_settings()
