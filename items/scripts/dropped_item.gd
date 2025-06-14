extends Node2D

@export var item: Item
@onready var icon = get_node("Icon")
var direction : Vector2
var target : Vector2
@onready var quantity = $ItemQuantity

func dropped_item():
	pass
	
func _ready():
	if item:
		icon.texture = item.icon
		quantity.text = str(item.quantity)
	$despawn_timer.start()	

func _on_despawn_timer_timeout():
	queue_free()

func _on_area_2d_body_entered(body: Node2D):
	if body.has_method("player"):
		body.inventory.add_item(item)
		queue_free()
			
func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent.has_method("dropped_item") and parent.item.name == item.name:
		if item.quantity >= parent.item.quantity:
			item.quantity += parent.item.quantity
			parent.queue_free()
			quantity.text = str(item.quantity)

			
func _process(delta):
	if target:
		position += direction * 80 * delta
	if (position.x > target[0] - 3 and position.x < target[0] + 3) and (position.y > target[1] - 3 and position.y < target[1] + 3):
		target = Vector2()
	
