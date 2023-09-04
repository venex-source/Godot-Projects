extends Control

@onready var scene_tree = get_tree()

@onready var level_select_container = $Background/MarginContainer/LevelSelectContainer
@onready var level_complete_container = $Background/MarginContainer/LevelCompleteContainer

@onready var level_grid = level_select_container.get_node("CenterContainer/LevelGrid")
@onready var message_texture = level_complete_container.get_node("MessageTexture")
@onready var star_texture = level_complete_container.get_node("StarsTexture")
@onready var score_label = level_complete_container.get_node("VBoxContainer/ScoreContainer/Label")
@onready var coin_collected = level_complete_container.get_node("VBoxContainer/CoinPickedContainer/Label")
@onready var next_container = level_complete_container.get_node("ButtonsContainer/NextBoxContainer")


const WIN_IMG = preload("res://assets/Sprites/LevelComplete/YouWin.png")
const LOSE_IMG = preload("res://assets/Sprites/LevelComplete/YouLose.png")

func _ready():
	toggle_level_menu()
	for level in level_grid.get_children():
		level.connect("level_selected", play_selected_level)

func _on_back_button_pressed():
	scene_tree.change_scene_to_file("res://scene/Screens/mainscreen.tscn")

func _on_next_button_up():
	$Fader.fade_screen(true, func(): scene_tree.change_scene_to_file("res://scene/Levels/level_" + str(Event.curr_level + 1) + ".tscn"))


func _on_levels_button_up():
	Event.select_level = true
	toggle_level_menu()


func _on_home_button_up():
	$Fader.fade_screen(true, func(): scene_tree.change_scene_to_file("res://scene/Screens/mainscreen.tscn"))


func play_selected_level(level_num: int) -> void:
	Event.curr_level = level_num
	$ClickAudio.play()
	$Fader.fade_screen(true, func(): scene_tree.change_scene_to_file("res://scene/Levels/level_" + str(level_num) + ".tscn"))


func unlock_next_level() -> void:
	if Event.curr_level < level_grid.get_child_count():
		var next_level = level_grid.get_child(Event.curr_level)
		if next_level.locked:
			next_level.locked = false


func set_level_finished_data() -> void:
	next_container.visible = Event.curr_level_passed and Event.curr_level < level_grid.get_child_count() #Next Level Node
	message_texture.texture = WIN_IMG if Event.curr_level_passed else LOSE_IMG
	score_label.text = "%d" % Event._mob_score_point
	coin_collected.text = "%d" % Event.coins_taken
	if Event.curr_level_passed:
		unlock_next_level()


func toggle_level_menu() -> void:
	level_select_container.visible = Event.select_level
	$BackButton.visible = Event.select_level
	if not Event.select_level:
		set_level_finished_data()
	level_complete_container.visible = not Event.select_level
