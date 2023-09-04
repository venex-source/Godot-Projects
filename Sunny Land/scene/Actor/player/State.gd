extends Node
class_name State

var state_machine = null
var playback: AnimationNodeStateMachinePlayback

func physics_update(_delta) -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func enter(_msg:={}):
	pass

func exit():
	pass
