extends Area2D
class_name Collectable

const ITEM_FEEDBACK = preload("res://scene/Effects/item_feedback_effect.tscn")

func item_collected() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$AudioStreamPlayer.play()
	hide()
	instance_item_feedback()


func instance_item_feedback() -> void:
	var item_effect = ITEM_FEEDBACK.instantiate()
	item_effect.destroy_item.connect(destroy)
	get_parent().add_child(item_effect)
	item_effect.global_position = global_position


func destroy() -> void:
	queue_free()
