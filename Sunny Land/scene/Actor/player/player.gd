extends Actor
class_name Player

signal game_over

@export var RUN_SPEED: float = 100.0
@export var JUMP_IMPULSE: float = 150.0
@export var start_position: Vector2 = Vector2.ZERO
@export var player_health: int = 3

@onready var anim_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

var move_direction: float
var hanging_on_ladder: bool = false
var damage_taken: bool = false

func _ready():
	$AnimationTree.active = true


func _physics_process(_delta):
	if not is_on_floor() and not hanging_on_ladder:
		velocity.y += gravity * _delta
	move_direction = Input.get_axis("move_left", "move_right")
	if move_direction and not damage_taken:
		velocity.x = move_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	update_facing_direction()
	move_and_slide()
	apply_push()


func take_damage(damage: int) -> void:
	if not damage_taken:
		player_health -= damage
		damage_taken = not damage_taken
		Event.emit_signal("health_changed", player_health)


func extra_live(value) -> void:
	player_health += value
	Event.emit_signal("increase_health", player_health)

func update_facing_direction():
	if move_direction > 0:
		anim_sprite.flip_h = false
	elif move_direction < 0:
		anim_sprite.flip_h = true


func apply_push():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is MovablePlatform:
			collision.get_collider().slide(-collision.get_normal())
