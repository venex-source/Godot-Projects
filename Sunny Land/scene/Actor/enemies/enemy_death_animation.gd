extends AnimatedSprite2D

func _ready():
	connect("animation_finished", _on_animation_finished)


func _on_animation_finished() -> void:
	queue_free()
