extends Node
class_name Breakable

var ID: String = ""
var state: String = "default" # default, broken

var max_durability: int
var current_durability: int

var dropped_item = preload("res://items/scenes/dropped_item.tscn")
var resource

@onready var respawn = $respawn
@onready var marker = $Marker2D
@onready var animations = $AnimatedSprite2D
@onready var hitbox = $StaticBody2D/CollisionShape2D 

func _ready(): 
	hitbox.shape.size = animations.sprite_frames.get_frame_texture("default", 0).get_size() * 0.75
	
func play_animation(animation = "default"):
	animations.play(animation)
	
func _on_respawn_timeout() -> void:
	state = "default"
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	current_durability = max_durability
	
func hit():
	if current_durability:
		current_durability -= 1
		if current_durability <= 0:
			destroy()
	
func destroy():
	state = "broken"
	respawn.start()
	drop_resource()

func drop_resource():
	var dropped_item_instance = dropped_item.instantiate()
	dropped_item_instance.item = resource
	dropped_item_instance.position = marker.position
	add_child(dropped_item_instance)
	
