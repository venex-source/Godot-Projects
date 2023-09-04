extends Player_State

@export var glide_speed: float = 105.0

func enter(msg := {}) -> void:
	player.SPEED = glide_speed

	if msg.has("do_jump"):
		playback.travel("jumping")
		player.velocity.y = -player.JUMP_IMPULSE


func physics_update(_delta: float) -> void:
	if player.is_on_floor():
		state_machine.transition_to("Idle")

	if player.velocity.y > 0 and playback.get_current_node() != "falling":
		# Checking if playback not equals "falling" to stop setting playback to falling
		playback.travel("falling")
