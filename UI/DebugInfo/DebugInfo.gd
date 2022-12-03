# Note: this is a singleton, don't forget to 
# add DebugInfo.tscn to project settings -> autoload

extends CanvasLayer

onready var enabled = OS.is_debug_build()
onready var label : Label = get_node("Label")
var lines : Dictionary

func add_line(info_key: String, info_text: String):
	lines[info_key] = info_text
	
func _process(_delta):
	if (Input.is_action_just_pressed("toggle_debug")):
		enabled = !enabled
		
	if enabled:
		label.text = ""
		label.text += "FPS: " + String(Engine.get_frames_per_second()) + "\n"
		label.text += "Memory: " + String(OS.get_static_memory_usage()) + "\n\n"
		for info_key in lines:
			label.text += lines[info_key] + "\n"
	else:
		label.text = ""
