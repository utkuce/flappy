extends Node2D

onready var player = $Player

func _ready():
	var screenSize = get_viewport().size
	var playerX = screenSize.x/4
	var playerY = screenSize.y/2
	player.position = Vector2(playerX, playerY)
