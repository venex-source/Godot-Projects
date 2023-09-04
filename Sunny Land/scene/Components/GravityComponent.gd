extends Node

@onready var character_body2D: CharacterBody2D = get_node(character_body2D_path) as CharacterBody2D

@export var character_body2D_path: NodePath = ".."
@export var acceleration: float = 50.0
@export var direction: Vector2 = Vector2(0, 1)

func _physics_process(delta):
	if character_body2D.is_on_floor() and character_body2D.velocity.y > 0:
		character_body2D.velocity.y = 0
		return
	character_body2D.velocity += acceleration * direction * delta
