tool 
extends Button

export(String, FILE) var next_scene: = "" 

func _on_button_up():
	get_tree().change_scene("res://src/Levels/LevelTemplate.tscn")

func _get_configuration_warning():
	return "next_scene_path must be set for the button to work" if next_scene == "" else ""
