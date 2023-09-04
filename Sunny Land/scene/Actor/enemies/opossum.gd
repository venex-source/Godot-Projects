extends Enemy

@onready var danger_detector_left: RayCast2D = get_node("DangerDetectorLeft") as RayCast2D
@onready var danger_detector_right: RayCast2D = get_node("DangerDetectorRight") as RayCast2D
@onready var anim_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var stats = $Stats

const WALK_SPEED = 40.0
const RUN_SPEED = 70.0
const FRAME_SPEED_SCALE = 0.5


func _ready():
	anim_sprite.speed_scale = 1.0
	velocity.x = WALK_SPEED * (-1 if randi_range(0, 1) else 1)


func _on_stats_out_of_health():
	die()


func _on_chase_began(new_direction):
	anim_sprite.speed_scale += FRAME_SPEED_SCALE
	SPEED = RUN_SPEED
	velocity.x = new_direction * SPEED


func _on_chase_ended():
	anim_sprite.speed_scale -= FRAME_SPEED_SCALE
	SPEED = WALK_SPEED


func _physics_process(_delta):
	calculate_move_velocity()
	animation_player.play("move_right" if velocity.x  > 0 else "move_left")
	move_and_slide()


func take_damage(damage: int) -> void:
	stats.health -= damage


func calculate_move_velocity():
	if not danger_detector_left.is_colliding() or (danger_detector_left.is_colliding() and danger_detector_left.get_collider() is Spike):
		velocity.x = SPEED
	elif not danger_detector_right.is_colliding() or (danger_detector_right.is_colliding() and danger_detector_right.get_collider() is Spike):
		velocity.x = -SPEED
	if is_on_wall():
		velocity.x = get_wall_normal().x * SPEED
