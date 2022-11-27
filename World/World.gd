extends Node2D

func _ready():
	var screenSize = get_viewport().size
	$Player.position = Vector2(screenSize.x/4, screenSize.y/2)
