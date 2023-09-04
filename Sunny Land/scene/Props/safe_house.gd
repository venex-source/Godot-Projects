extends Area2D

signal level_completed

@export var door_is_opened: bool = false

@onready var sprite: Sprite2D = get_node("DoorSprite")
@onready var collision: CollisionShape2D = get_node("CollisionShape2D")

const door_open_texture = preload("res://assets/Sprites/Sunny-land-files/PNG/environment/props/door-opened.png")
const door_closed_texture = preload("res://assets/Sprites/Sunny-land-files/PNG/environment/props/door.png")

func door_state() -> void:
	door_is_opened = true
	sprite.texture = door_open_texture if door_is_opened else door_closed_texture
	collision.disabled = not door_is_opened

func _on_body_entered(body):
	if body is Player:
		level_completed.emit()
