extends Node2D

onready var debugInfo : CanvasLayer = $"/root/DebugInfo"

export var pulse = 1200
export var gravity = 50
export var velocityX = 400

var velocity = Vector2(velocityX, 0)
var falling: bool = false

func _ready():
	velocity = Vector2(velocityX, 0)
	$AnimatedSprite.play()

func _physics_process(delta):
	falling = velocity.y > 0
	if (falling):
		if Input.is_action_pressed("primary_input"):
			$AnimatedSprite.play()
			velocity.y = -pulse
		else:
			$AnimatedSprite.stop()
			$AnimatedSprite.frame = 1
		
	velocity.y += gravity
	position.x += velocity.x * delta
	position.y += velocity.y * delta
	rotation_degrees = range_lerp(velocity.y, pulse, -pulse, 90, -90)
	
	# boundary checks
	if position.y < 0 || position.y > get_parent().screenSize.y:
		get_node("/root/Game").player_died()

func _process(_delta):
	if OS.is_debug_build():
		debugInfo.add_line("player_velocity", "Velocity: " + String(velocity))
		debugInfo.add_line("player_position", "Position: " + String(position.floor()))
		debugInfo.add_line("player_falling", "Falling: " + String(falling))
