extends ColorRect
class_name ItemSlot

@onready var icon = $ItemIcon
@onready var quantity = $ItemQuantity
@onready var selected = $Selected
@export var item : Item = null
@onready var button = $Button

func _ready():
	button.pressed.connect(_on_button_pressed)
	
func display_item():
	if item:
		icon.texture = item.icon
		quantity.text = str(item.quantity)
	else:
		icon.texture = null
		quantity.text = ""
		
func _on_button_pressed():
	pass

#func _get_drag_data(at_position:Vector2) -> Variant:
	#
	#return
#
#func _can_drop_data(at_position:Vector2, data:Variant) -> bool:
	#return typeof(data) == 24 # InventorySlot type (also works with item idk)
	#
#func _drop_data(at_position:Vector2, data:Variant) -> void:
	#var color = data["color"]
 
