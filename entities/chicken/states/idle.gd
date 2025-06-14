extends State

@export var wander_state: State
var swap_states: bool

func enter() -> void:
	parent.state = parent.States.IDLE
	self.animations = "idle"
	super()
	$switch_state.wait_time = randf_range(1.0, 3.0)
	$switch_state.start()
	swap_states = false
	print("idling")
	
func process_frame(float) -> State:
	return wander_state if swap_states == true else null
	
func _on_switch_state_timeout() -> void:
	swap_states = true
	
