extends Player_State

func enter(_msg := {}) -> void:
	player.SPEED = player.RUN_SPEED


func handle_input(event: InputEvent):
	if event.is_action_released("jump") and player.is_on_floor():
		state_machine.transition_to("Air", {do_jump = true})

	if event.is_action_released("move_left") or event.is_action_released("move_right"):
		state_machine.transition_to("Idle")


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
