extends Enemy

@onready var anim_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var cool_timer: Timer = get_node("CoolTimer")
@onready var stats = $Stats

@export var JUMP_VELOCITY = 40.0

var attack_enemy: bool = false
var just_jumped: bool = false
var direction: int


func _on_stats_out_of_health():
	die()


func _on_chase_began(_direction):
	self.direction = _direction
	attack_enemy = true
	update_facing_direction()


func _on_chase_ended():
	attack_enemy = false


func _on_cool_timer_timeout():
	just_jumped = false


func _physics_process(_delta):
	update_animation()
	jump_chase_movement()
	move_and_slide()
	if just_jumped and cool_timer.is_stopped() and is_on_floor():
		velocity = Vector2.ZERO
		cool_timer.start()


func take_damage(damage: int) -> void:
	stats.health -= damage


func jump_chase_movement() -> void:
	if attack_enemy and is_on_floor() and not just_jumped:
		velocity = Vector2(direction * SPEED, -JUMP_VELOCITY)
		anim_sprite.play("jumping")
		just_jumped = true


func update_animation() -> void:
	if velocity.y > 0:
		anim_sprite.play("idle" if is_on_floor() else "falling")


func update_facing_direction() -> void:
	if direction > 0:
		anim_sprite.flip_h = true
	elif direction < 0:
		anim_sprite.flip_h = false
