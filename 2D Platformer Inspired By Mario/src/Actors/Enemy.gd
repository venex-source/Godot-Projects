extends "res://src/Actors/Actor.gd"

export var score: = 100

func _ready():
	set_physics_process(false)
	_velocity.x = -speed.x  

func _on_StompDetector_body_entered(body) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	die()

func _physics_process(delta):
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()
	PlayerData.score += score
