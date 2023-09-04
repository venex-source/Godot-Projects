extends Node

signal coin_collected(coin_value)
signal health_changed(health_value)
signal increase_health(health_value)

var _mob_score_point: int = 0
var total_coin: int = 0
var select_level: bool = true:
	set = set_select_level, get = get_select_level
var coins_taken: int = 0:
	set = set_coin_taken
var curr_level_passed: bool = false
var curr_level: int = 1


func set_coin_taken(value) -> void:
	coins_taken = value
	total_coin += value

func set_select_level(value) -> void:
	select_level = value

func get_select_level() -> bool:
	return select_level
