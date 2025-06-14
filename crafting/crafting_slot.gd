class_name CraftingSlot extends ItemSlot
var requirements : Array[Item]
signal button_pressed(slot)

func _on_button_pressed():
	emit_signal("button_pressed")

	
	
