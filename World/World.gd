extends Node2D

var screenSize : Vector2

func _ready():
	screenSize = get_viewport().size * $Camera2D.zoom
	$Player.position = Vector2(screenSize.x/5, screenSize.y/2)
	$Pipes.init(screenSize)
	
func _physics_process(_delta):
	if $Player.position.y < 0 || $Player.position.y > screenSize.y:
		$Player.player_died()
