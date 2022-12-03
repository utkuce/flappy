extends Area2D

onready var visibilityNotifier = VisibilityNotifier2D.new()

var playerDied = false
func _ready():
	connect("area_entered", self, "on_area_entered")
	add_child(visibilityNotifier)
	visibilityNotifier.connect("screen_exited", self, "on_screen_exited")
	
func on_screen_exited():
	queue_free()
	
func notify_player_died():
	get_node("/root/Game").player_died()
		
func on_area_entered(area: Area2D):
	if area.owner && area.owner.name == "Player":
		call_deferred("notify_player_died")
		
func on_visibility_changed():
	print("exited")
	
func set_corners(topLeft, bottomRight):
	name = "PipeCollider " + String(topLeft) + "" + String(bottomRight)
	
	var width = bottomRight.x - topLeft.x
	var height = bottomRight.y - topLeft.y
	
	get_node("CollisionShape2D").shape.extents = Vector2(width/2, height/2)
	position = Vector2(topLeft.x + width/2, topLeft.y + height/2)
