extends ColorRect
class_name InventorySlot

@onready var icon = $ItemIcon
@onready var quantity = $ItemQuantity
@onready var selected = $Selected

func display_item(item: Item):
	if item:
		icon.texture = item.icon
		quantity.text = str(item.quantity)
	else:
		icon.texture = null
		quantity.text = ""
		
