tool 
extends Button

export var next_scene: PackedScene

func _on_button_up():
	PlayerData.score = 0
	PlayerData.deaths = 0
	get_tree().paused = false
	get_tree().change_scene_to(next_scene)

func _get_configuration_warning():
	return "The next scene property can't be empty" if not next_scene else ""
