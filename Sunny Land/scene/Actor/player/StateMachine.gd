extends Node
class_name CharacterStateMachine

signal transitioned(state_name)

@export var initial_state: = NodePath()
@export var anim_tree: AnimationTree

@onready var state: State = get_node(initial_state)

func _ready():
	await owner.ready
	for child in get_children():
		child.state_machine = self
		child.playback = anim_tree["parameters/playback"]
	state.enter()

func _input(event):
	state.handle_input(event)

func _physics_process(delta):
	anim_tree.set("parameters/move/blend_position", owner.move_direction)
	state.physics_update(delta)

func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
