extends Node2D

func _process(delta):
	$AnimatedSprite2D.play(Global.season[Global.current_season])
