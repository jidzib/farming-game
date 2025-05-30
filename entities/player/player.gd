extends CharacterBody2D
class_name Player

# states
enum States {IDLE, WALKING, RUNNING, AXE_SWING}
var state: States = States.WALKING # States.IDLE, States.WALKING, etc

# movement
const accel = 10
var movement: Vector2
var current_dir = "right"
var sprinting = 1
@export var SPEED: int = 150

# animation
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var animations: String = "idle_down"

# inventory
@onready var inventory = $Inventory
@onready var selected_slot_object = inventory.container.get_child(0)
var inventory_slots = [49, 50, 51, 52, 53, 54, 55, 56] # keycodes for 1-8
var selected_slot_num = 0

# state machine
@onready var state_machine = $state_machine

# Raycasting
@onready var raycast = $RayCast2D
@export var raycast_length = 32

func player():
	pass
	
func _ready():
	state_machine.init(self)
	
func _input(event):
	if event.is_action_pressed("inventory"):
		inventory_switch()
	if event is InputEventKey and event.keycode in inventory_slots:
		selected_slot_num = int(event.as_text()) - 1
		hotbar_select()
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func hotbar_select():
	selected_slot_object.selected.visible = false
	selected_slot_object = inventory.container.get_child(selected_slot_num)
	selected_slot_object.selected.visible = true
	print("Now selected: ", inventory.inventory[0][selected_slot_num])
	
func inventory_switch():
		# open or close inventory	
	for i in range(inventory.get_node("MarginContainer").get_node("GridContainer").columns * 3, 0, -1):
		var node_to_hide = inventory.get_node("MarginContainer").get_node("GridContainer").get_child(i)
		node_to_hide.visible = !node_to_hide.visible


		
