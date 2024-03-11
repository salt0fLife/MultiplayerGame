extends Node3D

@export var powered := false


func interact():
	if $LightSwitch/AnimationPlayer.current_animation == "on":
		powered = true
		pass
	else:
		powered = false
		pass
	
	if powered:
		powerOff()
		pass
	else:
		powerOn()
		pass
	
	pass

func powerOn():
	$LightSwitch/AnimationPlayer.play("on")
	powered = true
	for child in get_children(false):
		if child.has_method("on"):
			child.on()
			pass
		pass
	pass

func powerOff():
	$LightSwitch/AnimationPlayer.play("off")
	powered = false
	for child in get_children(false):
		if child.has_method("off"):
			child.off()
		pass
	pass
