extends State

@export var idle_state: State
@export var walk_state: State

var swinging = false

func enter() -> void:
	parent.state = parent.States.AXE_SWING
	swinging = true
	animations = "axe_swing"
	parent.animated_sprite.play(animations)
	$swinging.start()
	
	var collided_object = parent.raycast.get_collider()
	if collided_object != null:
		if collided_object.ID == "tree":
			collided_object.hit()	
			print("break tree")
			
		
	
func process_frame(delta: float) -> State:
	if swinging == false:
		return idle_state
	return null

#func process_input(event: InputEvent) -> State:
	#return idle_state


func _on_swinging_timeout() -> void:
	swinging = false
