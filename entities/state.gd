extends Node

class_name State

@export var animations: String
@export var move_speed: float = 150

const accel = 10
var parent: Player

func enter() -> void:
	parent.animated_sprite.play(animations)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func update_raycast() -> void:
	# raycast handling
	var dir_vector = Vector2.ZERO
	match parent.current_dir:
		"right": dir_vector = Vector2.RIGHT
		"left": dir_vector = Vector2.LEFT
		"up": dir_vector = Vector2.UP
		"down": dir_vector = Vector2.DOWN
	parent.raycast.target_position = dir_vector * parent.raycast_length
	parent.raycast.enabled = true
		
