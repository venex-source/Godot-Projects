extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: = get_node("PauseOverlay")
onready var score: Label = get_node("Label")
onready var pause_title: Label = get_node("PauseOverlay/Title")

const DIED_MESSAGE: = "You died"

var paused: = false setget set_paused

func _ready():
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_PlayerData_player_died")
	update_interface()

func _PlayerData_player_died() -> void:
	self.paused = true
	pause_title.text = DIED_MESSAGE

func _unhandled_input(event):
	if event.is_action_pressed("pause") and pause_title.text != DIED_MESSAGE:
		self.paused = not paused
		scene_tree.set_input_as_handled()

func update_interface():
	score.text = "Score: %s" % PlayerData.score

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
