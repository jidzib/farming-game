extends State

@export var idle_state: State
var valid_moves = []

var iteration : int
var space_state

func enter() -> void:
	space_state = get_viewport().get_world_2d().direct_space_state
	parent.state = parent.States.WANDER
	self.animations = "walk"
	super()
	
func process_physics(delta: float) -> State:
	return null
func process_frame(float) -> State:
	return null
