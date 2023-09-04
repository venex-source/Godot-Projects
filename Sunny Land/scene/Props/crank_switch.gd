extends Area2D

signal open_door

const crank_up = preload("res://assets/Sprites/Sunny-land-files/PNG/environment/props/crank-up.png")

func _on_body_entered(body):
	if body.name == "Player":
		$Sprite2D.texture = crank_up
		self.disconnect("body_entered", _on_body_entered)
		open_door.emit()
