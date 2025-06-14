extends Resource
class_name Recipe

@export var item : Item
@export var requirements : Array[Item]
enum Types {CRAFTING, COOKING}
@export var type = Types.CRAFTING
