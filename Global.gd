extends Node

var season = ["spring", "summer", "fall", "winter"]
var current_season = 0

func _process(delta):
	if Input.is_action_just_pressed("change_season"):
		if current_season == 3:
			current_season = 0
		else: current_season += 1
