extends Node3D



func on():
	$ceilingLight/AnimationPlayer.play("on")
	pass

func off():
	$ceilingLight/AnimationPlayer.play("off")
	pass
