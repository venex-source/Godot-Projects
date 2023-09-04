extends Player_State


func _init():
	Event.connect("health_changed", _on_player_health_changed)

func revive_player():
	player.global_position = player.start_position
	player.damage_taken = false
	state_machine.transition_to("Idle")
	playback.travel("revive")


func enter(_msg := {}) -> void:
	playback.travel("hurt")


func _on_player_health_changed(lives_left):
	if lives_left > 0:
		state_machine.transition_to("Hurt")
	else:
		state_machine.transition_to("Death")
		playback.travel("hurt")
		player.game_over.emit()
