extends Control

func _input(event):
	if not event is InputEventMouseMotion and not event is InputEventMouseButton:
		if not event.is_released():
			get_node("type/{IDX}".format({
				"IDX": randi_range(0, 3)
			})).play()

func _ready():
	get_viewport().transparent_bg = true
	$splash.show()
	$anims.play("splash")
	$open.play()
	$fizz.emitting = true
	
	# connect events
	$panel/container/status/controls/close.connect("button_down", SHELLBY.exitshell)
	$panel/container/status/controls/minimize.connect("button_down", SHELLBY.minshell)
	
	await $anims.animation_finished
	var nsession = SHELLBY.isession.instantiate()
	$panel/container.add_child(nsession)
	$panel/container.move_child(nsession, 1)
