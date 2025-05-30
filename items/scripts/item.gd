extends Resource
class_name Item

@export var name: String = ""
@export var description: String = ""
@export var icon: Texture2D
@export var type: Enums.ItemType = Enums.ItemType.CONSUMABLE
@export var quantity: int = 1
@export var id: int
