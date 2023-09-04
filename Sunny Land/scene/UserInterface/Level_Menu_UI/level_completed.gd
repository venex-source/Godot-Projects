extends Control

@onready var message_texture = $TextureRect/MarginContainer/VBoxContainer/MessageTexture
@onready var star_texture = $TextureRect/MarginContainer/VBoxContainer/StarsTexture
@onready var time_spent_label = $TextureRect/MarginContainer/VBoxContainer/VBoxContainer/TimePlayedContainer/Label2
@onready var coin_collected = $TextureRect/MarginContainer/VBoxContainer/VBoxContainer/CoinPickedContainer/Label2
@onready var next_container = $TextureRect/MarginContainer/VBoxContainer/ButtonsContainer/NextBoxContainer

const WIN_IMG = preload("res://assets/Sprites/LevelComplete/YouWin.png")
const LOSE_IMG = preload("res://assets/Sprites/LevelComplete/YouLose.png")


func _ready():
	Event.game_ended.connect(_on_level_finished)


func _on_next_button_pressed():
	pass # Replace with function body.


func _on_levels_button_pressed():
	get_tree().change_scene_to_file("res://scene/UserInterface/Level_Menu_UI/level_menu.tscn")


func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scene/Screens/mainscreen.tscn")

func set_message_texture(value) -> void:
	message_texture.texture = WIN_IMG if value else LOSE_IMG

func set_time_spent(value) -> void:
	time_spent_label.text = "%0d:%02d" % to_minutes_second(value)


func _on_level_finished(level_completed: bool) -> void:
	next_container.visible = level_completed #Next Level Node
	set_message_texture(level_completed) #You Win/Lose
	set_time_spent(30) #Time Label
	coin_collected.text = "%d" % Event.coins_taken
	show()

func to_minutes_second(value: int) -> Array:
	var minute = int(value / 60)
	var second = value % 60
	return [minute, second]
