extends StaticBody2D

@onready var grid_container = $UI/ScrollContainer/GridContainer
@onready var ui = $UI
@onready var requirements = $UI/Requirements/ScrollContainer/VBoxContainer
var ID = "crafting_bench"
var crafting_slot = preload("res://crafting/crafting_slot.tscn")
var item_slot = preload("res://items/scenes/item_slot.tscn")
@onready var craft_button = $UI/Requirements/Button
signal pressed_craft
var selected_recipe: Recipe

func _ready():
	ui.visible = false
	
func _process(delta: float) -> void:
	pass

func open_menu(player: Player):
	ui.visible = !ui.visible
	if ui.visible == false:
		for child in grid_container.get_children():
			child.queue_free()
		return
	for recipe in player.known_recipes:
		var slot_instance = crafting_slot.instantiate()
		if recipe:
			slot_instance.item = recipe.item.duplicate(true)
			slot_instance.requirements = recipe.requirements.duplicate(true)
		slot_instance.button_pressed.connect(display_requirements.bind(slot_instance, recipe))	
		grid_container.add_child(slot_instance)	
		slot_instance.display_item()	

func display_requirements(slot_instance, recipe):
	if recipe:
		selected_recipe = recipe.duplicate(true)
	if requirements.get_child_count() > 0:
		for child in requirements.get_children():
			child.queue_free()
	for requirement in slot_instance.requirements:
		var requirement_instance = item_slot.instantiate()
		requirements.add_child(requirement_instance)
		requirement_instance.item = requirement.duplicate(true)
		requirement_instance.display_item()
	
func craft(recipe: Recipe, inventory: Inventory):
	if recipe:
		# iterate through required items in recipe.requirements
		for item in recipe.requirements:
			# checks if inventory_search has item / if item exists in inventory, returns if it doesn't
			if item.name not in inventory.inventory_search:
				return
			
			# gets the indices of the item in inventory based on inventory_search
			var i = inventory.inventory_search[item.name][0]
			var j = inventory.inventory_search[item.name][1]
			
			# checks if there is enough of the item in the inventory for the recipe. returns if there isn't
			if item.quantity > inventory.inventory[i][j].item.quantity:
				return
		
		# since we made it this far, we have the required items and amount for each item to craft
		# so we iterate through recipe.requirements again
		for item in recipe.requirements:
			var slot = inventory.inventory_search[item.name]
			inventory.remove_item(slot, item.quantity)
		inventory.add_item(recipe.item)
		
func _on_button_pressed():
	craft(selected_recipe, get_tree().get_nodes_in_group("player")[0].inventory)
