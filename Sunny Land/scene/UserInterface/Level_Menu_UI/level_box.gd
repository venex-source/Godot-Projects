@tool
extends TextureButton

signal level_selected

@export var locked = true:
	set = set_locked
@export var level_num = 1:
	set = set_level

const lock_texture = preload("res://assets/lock.png")

@onready var level_ready = $MarginContainer/LevelReady

func set_locked(value: bool) -> void:
	locked = value
	if not is_inside_tree():
		await ready
	
	level_ready.texture = lock_texture if locked else load("res://assets/Sprites/Numbers/" + str(level_num) + ".png")

func set_level(value: int) -> void:
	level_num = value
	if not is_inside_tree():
		await ready

func _on_pressed():
	if locked:
		return
	else:
		level_selected.emit(level_num)
