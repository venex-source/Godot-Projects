extends Player_State

func enter(_msg := {}) -> void:
	# When entering stop movement and playback play idle(move)
	playback.travel("move")
	player.hanging_on_ladder = false

func handle_input(event: InputEvent):
	#Detect is player started moving
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		state_machine.transition_to("Run")

	if player.is_on_floor():
		if event.is_action_pressed("jump"):
			state_machine.transition_to("Air", {do_jump = true})
		
	# Transition to crouch state if down key pressed and on floor
		if event.is_action_pressed("crouch"):
			state_machine.transition_to("Crouch")
		
	# Transition to climb state if player can climb on floor and climb pressed
		if event.is_action_pressed("climb") and %LadderDetector.is_colliding():
			state_machine.transition_to("Climb")


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
	
	if player.move_direction:
		state_machine.transition_to("Run")
