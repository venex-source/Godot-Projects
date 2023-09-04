extends Control

@onready var camera_2D: Camera2D = get_node("Camera2D")
@onready var safe_house = get_node("SafeHouse")

func _ready():
	$CrankSwitch.open_door.connect(_on_crank_switch_open_door)
	$Player.game_over.connect(_on_game_over)
	$SafeHouse.level_completed.connect(_on_level_completed)

func _on_crank_switch_open_door():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(camera_2D, "position", safe_house.position, 2.0)
	tween.tween_callback(safe_house.door_state)

func _on_game_over() -> void:
	show_level_complete(false)

func _on_level_completed() -> void:
	show_level_complete(true)

func show_level_complete(value: bool) -> void:
	Event.select_level = false
	Event.curr_level_passed = value
	get_tree().change_scene_to_file("res://scene/UserInterface/Level_Menu_UI/level_menu.tscn")
