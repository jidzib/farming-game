extends CharacterBody2D
class_name Chicken

var ID = "chicken"

# states
enum States {IDLE, WANDER}
var state: States = States.IDLE # States.IDLE, States.WANDER, etc

# movement
const accel = 10
var movement: Vector2
var current_dir = "right"
@export var SPEED: int = 35

# animation
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var animations: String = "idle"

@onready var state_machine = $state_machine

@onready var hitbox = $CollisionShape2D.shape.size
var rand: int

func _ready():
	state_machine.init(self)
	randomize()
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
