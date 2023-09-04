extends HSlider

func _on_mouse_exited():
	release_focus()

func update_volume_value(_value) -> void:
	self.value = _value

func change_value(_value: float) -> void:
	self.value = _value
	
