class_name Enemy
extends Actor

@export var mob_point: int = 10
const EnemyDeathEffect = preload("res://scene/Actor/enemies/enemy_death_animation.tscn")

func create_death_effect() -> void:
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func die() -> void:
	Event._mob_score_point += mob_point
	queue_free()
	create_death_effect()
