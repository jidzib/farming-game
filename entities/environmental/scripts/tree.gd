extends Breakable

var season = ["spring", "summer", "fall", "winter"]
var current_season = 0


func _ready():
	resource = preload("res://resources/wood.tres")
	max_durability = 3
	current_durability = 3
	ID = "tree"
	respawn.wait_time = 5
	
func _process(delta):
	if Input.is_action_just_pressed("change_season"):
		if current_season == 3:
			current_season = 0
		else:
			current_season += 1
	
	if state == "default":
		$AnimatedSprite2D.play(season[current_season])
	if state == "broken":
		$AnimatedSprite2D.play("broken")
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	
		
