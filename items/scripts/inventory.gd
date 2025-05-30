extends Control
class_name Inventory

var inventory = []
@onready var container = $MarginContainer/GridContainer
var height = 4
var width = 8
var slot_scene = preload("res://items/scenes/inventory_slot.tscn")

func _ready():
	initialize_inventory()
	print("Initialized inventory")

func initialize_inventory():
	for i in range(height):
		inventory.append([])
		for j in range(width):
			var slot_instance = slot_scene.instantiate()
			inventory[i].append(null)
			print(type_string(typeof(slot_instance)))
			container.add_child(slot_instance)
			
func add_item(item: Item):
	# check if inventory already has the item
	for i in range(height):
		for j in range(width):
			if inventory[i][j] != null and inventory[i][j].id == item.id:
				# add to the quantity of the item
				inventory[i][j].quantity += item.quantity
				print("Total ", inventory[i][j].name, " in inventory is now ", inventory[i][j].quantity)
				# update display
				var slot_number = get_slot(i, j)
				container.get_child(slot_number).display_item(inventory[i][j])
				print("Updated slot ", slot_number)
				return
				
	# add to first empty slot if the inventory did not have the item
	for i in range(height):
		for j in range(width):
			if inventory[i][j] == null:
				# initialize a new reference to the item in the inventory
				inventory[i][j] = item.duplicate(true)
				# update display
				var slot_number = get_slot(i, j)
				container.get_child(slot_number).display_item(inventory[i][j])
				print(inventory[i][j].name, " initialized in slot ", slot_number)
				return
	
# get slot number, indexing starts at 0 (used for inventoryslot indexing)
func get_slot(i: int, j: int):
	var index = (width * i) + j
	return index
