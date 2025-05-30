extends Node2D

@export var item: Item
@onready var icon = get_node("Icon")

func _ready():
	if item:
		icon.texture = item.icon
	$despawn_timer.start()	

func _on_despawn_timer_timeout():
	queue_free()

func _on_area_2d_body_entered(body: Node2D):
	if body.has_method("player"):
		body.inventory.add_item(item)
		queue_free()
