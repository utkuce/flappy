extends Area2D

func _ready():
	connect("area_entered", self, "on_area_entered")

func on_area_entered(area: Area2D):
	if area.owner:
		print(area.owner.name + " entered pipe area")
	
func set_corners(topLeft, bottomRight):
	name = "PipeCollider" + String(topLeft) + "" + String(bottomRight)
	
	var width = bottomRight.x - topLeft.x
	var height = bottomRight.y - topLeft.y
	
	get_node("CollisionShape2D").shape.extents = Vector2(width/2, height/2)
	position = Vector2(topLeft.x + width/2, topLeft.y + height/2)
	
