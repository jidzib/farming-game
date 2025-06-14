extends State

@export var idle_state: State
@export var run_state: State
@export var axe_state: State

func enter() -> void:
	parent.state = parent.States.WALKING

func process_input(event: InputEvent) -> State:
	if parent.inventory.inventory[0][parent.selected_slot_num].item:
		if parent.inventory.inventory[0][parent.selected_slot_num].item.id == 3 and Input.is_action_just_pressed("use"):
			return axe_state
	if Input.is_action_pressed("run"):
		return run_state
	
	return null
func process_frame(delta: float) -> State:
	if parent.current_dir == Vector2(1, 0): # right
		animations = "walk_side" 
	elif parent.current_dir == Vector2(-1, 0): # left
		animations = "walk_side"
	elif parent.current_dir == Vector2(0, 1): # down
		animations = "walk_down"
	else:
		animations = "walk_up"
	parent.animated_sprite.play(animations)
	return null

func process_physics(delta: float) -> State:
	# handle player movement
	parent.movement.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	parent.movement.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	parent.movement = parent.movement.normalized()
	parent.velocity = lerp(parent.velocity, parent.movement * move_speed, delta * accel)
	parent.move_and_collide(parent.velocity * delta)
	
	# handle raycast direction
	update_raycast()
	
	# handle player direction
	if parent.movement.x > 0:
		parent.current_dir = Vector2(1, 0) # right
		parent.animated_sprite.flip_h = false
	elif parent.movement.x < 0:
		parent.current_dir = Vector2(-1, 0) # left
		parent.animated_sprite.flip_h = true
	elif parent.movement.y < 0:
		parent.current_dir = Vector2(0, -1) # up
	elif parent.movement.y > 0:
		parent.current_dir = Vector2(0, 1) # down
	else:
		return idle_state
	return null
