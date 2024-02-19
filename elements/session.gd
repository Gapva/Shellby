extends Control

var outputs = []

func _ready():
	$anims.play("in")
	$elements/path/prompt.grab_focus()
	$elements/path/prompt.connect("text_submitted", finish)
	$elements/path/user/label.text = SHELLBY.user.substr(0, 4)
	$elements/path/mode/label.text = SHELLBY.method.substr(0, 4)

func finish(_nt):
	#$elements/path/prompt.editable = false
	#var nsession = SHELLBY.isession.instantiate()
	#get_parent().add_child(nsession)
	$elements/path/prompt.grab_focus()
	var uraw = $elements/path/prompt.text
	$elements/path/prompt.clear()
	var raw = uraw.split(" ")
	var cmd = raw[0]
	var args = []
	for arg in raw.slice(1, len(raw)):
		if arg[0] == "-": args.append(arg)
	OS.execute("powershell.exe", ["-Command", " ".join(raw)], outputs, false, true)
	SHELLBY.historyc(uraw, outputs[-1])
	var noutput = SHELLBY.ioutput.instantiate()
	noutput.get_node("container/cmd").text = "> {CMD}".format({"CMD": uraw})
	noutput.get_node("container/out").text = outputs[-1]
	get_parent().get_node("scroll/elements").add_child(noutput)
	get_parent().get_node("scroll/elements").move_child(noutput, 0)
	noutput.get_node("anims").play("in")
	noutput.get_node("add").play()
