extends Area2D

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
@onready var timer: Timer = get_node("Timer")

func _init():
	monitorable = false


func _ready():
	self.connect("area_entered", _on_body_entered)
	timer.timeout.connect(_invicibility_timeout)


func _on_body_entered(hitbox: HitBox):
	if owner.has_method("take_damage"):
		_invincible_start()
		owner.take_damage(hitbox.damage)

func _invicibility_timeout() -> void:
	collision_shape.disabled = false


func _invincible_start() -> void:
	collision_shape.set_deferred("disabled", true)
	timer.start()
	
