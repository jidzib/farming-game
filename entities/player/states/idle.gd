extends State

@export var walk_state: State
@export var axe_state: State

func enter() -> void:
	parent.state = parent.States.IDLE
	if parent.current_dir == "right":
		self.animations = "idle_side"
	elif parent.current_dir == "left":
		self.animations = "idle_side"
	elif parent.current_dir == "down":
		self.animations = "idle_down"
	else:
		self.animations = "idle_up"
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0
	
	update_raycast()
	
func process_input(event: InputEvent) -> State:
	if parent.inventory.inventory[0][parent.selected_slot_num]:
		if parent.inventory.inventory[0][parent.selected_slot_num].id == 3 and Input.is_action_just_pressed("use"):
			return axe_state
	if (Input.is_action_just_pressed("up")
	 or Input.is_action_just_pressed("down") 
	or Input.is_action_just_pressed("left")
	or Input.is_action_just_pressed("right")):
		return walk_state
	return null
	
func process_physics(delta: float) -> State:
	return null
