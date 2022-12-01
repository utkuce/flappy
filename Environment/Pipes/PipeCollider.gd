extends Area2D

var playerDied = false

func _ready():
	connect("area_entered", self, "on_area_entered")
	
func _physics_process(delta):
	if (playerDied):
		get_node("/root/Game").player_died()
		
func on_area_entered(area: Area2D):
	if area.owner && area.owner.name == "Player":
		playerDied = true 
		# player_died() needs to be called next physics frame
		# becuase it deletes nodes and deleting nodes during collison 
		# messes with the physics system, so we just set the variable 
		# here and wait for _physics_process to be called again
		
	
func set_corners(topLeft, bottomRight):
	name = "PipeCollider " + String(topLeft) + "" + String(bottomRight)
	
	var width = bottomRight.x - topLeft.x
	var height = bottomRight.y - topLeft.y
	
	get_node("CollisionShape2D").shape.extents = Vector2(width/2, height/2)
	position = Vector2(topLeft.x + width/2, topLeft.y + height/2)
	
