extends Node

const isession = preload("res://elements/session.tscn")
const ioutput = preload("res://elements/output.tscn")

var user = "user" # default username, user (will be replaced with an env var once run)
var method = "shby" # default cmdlet method, shby (shellby)

var rawhistory = []
var history = []

func historyc(cmdr, outputr):
	var cmd = cmdr.replace(OS.get_environment("USERNAME"), user)
	var output = outputr.replace(OS.get_environment("USERNAME"), user)
	rawhistory.append({"cmd": cmd, "output": output})
	history.append("> {CMD}\n{OUT}".format({"CMD": cmd, "OUT": output}))

func _ready():
	# add necessary files
	if not FileAccess.file_exists("user://alias.txt"):
		FileAccess.open("user://alias.txt", FileAccess.WRITE_READ).store_line(OS.get_environment("USERNAME"))
	user = FileAccess.open("user://alias.txt", FileAccess.READ).get_as_text().split("\n")[0].strip_edges()
	
	# move window for showcasing
	#get_viewport().get_window().current_screen = 1

func exitshell():
	get_tree().quit()

func minshell():
	get_viewport().get_window().set_mode(Window.MODE_MINIMIZED)
