extends Node

signal out_of_health
signal health_changed

@export var health: int = 1:
	set = set_health

func set_health(value: int) -> void:
	health = value
	if health <= 0:
		emit_signal("out_of_health")
	else:
		emit_signal("health_changed")
