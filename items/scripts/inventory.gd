extends Control
class_name Inventory

var inventory_search = {}
var inventory = []

@onready var container = $MarginContainer/GridContainer
var height = 4
var width = 8
var slot_scene = preload("res://items/scenes/item_slot.tscn")
var parent = self.get_parent()

func _ready():
	initialize_inventory()
	print("Initialized inventory")

func initialize_inventory():
	for i in range(height):
		inventory.append([])
		for j in range(width):
			var slot_instance = slot_scene.instantiate()
			inventory[i].append(slot_instance)
			print(type_string(typeof(slot_instance)))
			container.add_child(slot_instance)
			
func add_item(item: Item):
	# check if inventory already has the item. if not, adds it and stores name and index[i][j] in hashmap
	if item.name not in inventory_search:
		for i in range(height):
			for j in range(width):
				if inventory[i][j].item == null:
					inventory_search[item.name] = Vector2(i, j)
					inventory[i][j].item = item.duplicate(true)
					var slot_number = get_slot(i, j)
					#container.get_child(slot_number).display_item(inventory[i][j])
					container.get_child(slot_number).display_item()
					return
					
	# adds to quantity if inventory already has the item
	elif item.name in inventory_search:
		var i = inventory_search[item.name][0]
		var j = inventory_search[item.name][1]
		inventory[i][j].item.quantity += item.quantity
		var slot_number = get_slot(i, j)
		container.get_child(slot_number).display_item()

# get slot number, indexing starts at 0 (used for inventoryslot indexing)
func get_slot(i: int, j: int):
	var index = (width * i) + j
	return index

# drops single item at a time on ground
func drop_item(slot: int):
	# checks if selected slot has item
	if inventory[0][slot].item:
		print("dropped ", inventory[0][slot].item.quantity, " ", inventory[0][slot].item.name)
		inventory[0][slot].item.quantity -= 1 # iterate quantity down by 1
		
		# drop item on ground here
		var dropped_item = preload("res://items/scenes/dropped_item.tscn")
		var dropped_item_instance = dropped_item.instantiate()
		dropped_item_instance.item = inventory[0][slot].item.duplicate()
		dropped_item_instance.item.quantity = 1
		dropped_item_instance.position = get_tree().get_nodes_in_group("player")[0].position + get_tree().get_nodes_in_group("player")[0].current_dir * 13
		dropped_item_instance.direction = get_tree().get_nodes_in_group("player")[0].current_dir
		dropped_item_instance.target = get_tree().get_nodes_in_group("player")[0].position + get_tree().get_nodes_in_group("player")[0].current_dir * 40
		get_tree().get_root().add_child(dropped_item_instance)
		
		# if quantity drops to 0 or below, erase from inventory_search and set item in inventory to null
		if inventory[0][slot].item.quantity <= 0:
			inventory_search.erase(inventory[0][slot].item.name)
			inventory[0][slot].item = null
		container.get_child(slot).display_item()

func remove_item(slot: Vector2, amount: int):
	var i = slot[0]
	var j = slot[1]
	# check if selected slot has an item
	if inventory[i][j].item:
		inventory[i][j].item.quantity -= amount # iterate quantity down by desired amount
		
		# if quantity drops to 0 or below, erase from inventory_search and set item in inventory to null
		if inventory[i][j].item.quantity <= 0:
			inventory_search.erase(inventory[i][j].item.name)
			inventory[i][j].item = null
	var slot_number = get_slot(i, j)
	container.get_child(slot_number).display_item()
