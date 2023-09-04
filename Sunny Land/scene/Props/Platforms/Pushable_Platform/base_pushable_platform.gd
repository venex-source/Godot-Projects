extends Actor
class_name MovablePlatform

func _physics_process(_delta):
	move_and_slide()
	# Stop Movement if not pushed
	velocity.x = 0

func slide(direction):
	velocity.x = int(direction.x) * SPEED
