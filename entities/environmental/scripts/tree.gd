extends Breakable

func _ready():
	resource = preload("res://resources/wood.tres")
	max_durability = 3
	current_durability = 3
	ID = "tree"
	respawn.wait_time = 5
	
func _process(delta):
	
	if state == "default":
		$AnimatedSprite2D.play(Global.season[Global.current_season])
	if state == "broken":
		$AnimatedSprite2D.play("broken")
		$CollisionShape2D.set_deferred("disabled", true)
	
		
