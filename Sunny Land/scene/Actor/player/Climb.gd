extends Player_State

@export var climb_speed: float = 50.0

var direction: float

func enter(_msg := {}) -> void:
	player.SPEED = climb_speed
	playback.travel("climb")


func handle_input(event: InputEvent) -> void:
	if (event.is_action_released("climb") or event.is_action_released("crouch")) and player.is_on_floor():
		state_machine.transition_to("Idle")


func physics_update(_delta: float) -> void:
	direction = Input.get_axis("climb", "crouch")
	if %LadderDetector.is_colliding():
		player.velocity.y = direction * climb_speed
		if not player.is_on_floor():
			player.hanging_on_ladder = true
	else:
		state_machine.transition_to("Idle")
