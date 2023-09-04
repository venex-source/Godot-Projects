extends AnimatedSprite2D

signal destroy_item

func _ready():
	animation_finished.connect(_on_animation_finished)
	play("Animate")

func _on_animation_finished() -> void:
	destroy_item.emit()
	queue_free()
