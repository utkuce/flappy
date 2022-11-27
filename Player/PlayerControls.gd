extends Node2D

export var pulse = 1000
export var gravity = 25

onready var velocity : float = 0

func _ready():
	pass

func _physics_process(delta):
	var falling = velocity > -10
	if (falling):
		if Input.is_action_pressed("primary_input"):
			velocity -= pulse
		
	velocity += gravity
	position.y += velocity * delta
