extends Control

@onready var health_container = $UI/VBoxContainer/HealthBoxContainer
@onready var scene_tree = get_tree()
@onready var pause_menu = $PauseSettigs
@onready var UI = $UI

var paused: bool = false:
	set = set_paused

const MAX_HEALTH = 3
const HEALTH_ICON = preload("res://scene/UserInterface/cherry_animation.tscn")

func _ready():
	Event.connect("health_changed", _on_health_changed)
	Event.connect("increase_health", _on_increase_health)
	Event.connect("coin_collected", _on_coin_collected)

func _on_settings_button_pressed():
	hide()
	SceneManager.show_open_settings()


func _on_home_button_pressed():
	paused = false
	scene_tree.change_scene_to_file("res://scene/Screens/mainscreen.tscn")


func _on_pause_button_pressed():
	paused = true


func _on_back_button_pressed():
	paused = false


func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_menu.visible = value
	UI.visible = not value


func _on_coin_collected(amount):
	Event.coins_taken += amount
	$UI/VBoxContainer/CoinBoxContainer/Label.text = "%d" % Event.coins_taken


func _on_health_changed(live):
	var lives_left = health_container.get_child_count()

	while live < lives_left and lives_left >= 0:
		lives_left -= 1
		health_container.remove_child(health_container.get_child(lives_left - 1))

func _on_increase_health(live):
	var lives_left = health_container.get_child_count()
	print("Live: ", live, "\nLives Left: ", lives_left)
	while live > lives_left and lives_left < MAX_HEALTH:
		var cherry = HEALTH_ICON.instantiate()
		health_container.add_child(cherry)
		lives_left += 1
