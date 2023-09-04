extends Player_State

var can_drop: bool = false

@export var crouch_speed: float = 30.0

@onready var timer: Timer = get_node("Timer")

func enter(_msg := {}) -> void:
	player.SPEED = crouch_speed
	playback.travel("crouch")


func handle_input(event: InputEvent):
	if event.is_action_released("crouch"):
		state_machine.transition_to("Idle")


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
	
	if Input.is_action_just_pressed("crouch"):
		if can_drop:
			player.position.y += 1
		else:
			timer.start()
			can_drop = true

func _on_timer_timeout():
	can_drop = false
