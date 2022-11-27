# Note: this is a singleton, don't forget to 
# add DebugInfo.tscn to project settings -> autoload

extends CanvasLayer

onready var label : Label = get_node("Label")
var lines : Dictionary

func add_line(info_key: String, info_text: String):
	lines[info_key] = info_text
	
func _process(_delta):
	if OS.is_debug_build():
		label.text = ""
		for info_key in lines:
			label.text += lines[info_key] + "\n"
