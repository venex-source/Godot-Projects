extends MarginContainer

@onready var life_couter = $HBoxContainer/LifeCounter.get_children()

func update_life(value):
	for heart in life_couter.size():
		life_couter[heart].visible = value > heart

func update_score(value):
	$HBoxContainer/Score.text = str(value)
