extends Node2D

func _ready():
	var screenSize : Vector2 = get_viewport().size * $Camera2D.zoom
	$Player.position = Vector2(screenSize.x/5, screenSize.y/2)
	$Pipes.init(screenSize)
