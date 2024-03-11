extends CharacterBody3D
@onready var navAgent = $NavigationAgent3D


var target = null
@export var speed := 10


func _on_sense_area_body_entered(body):
	target = body
	pass # Replace with function body.



func _on_timer_timeout():
	#var currentLocation = global_position
	#var nextLocation = navAgent.get_next_path_position()
	#var offset = (nextLocation - currentLocation)
	#var newVelocity = offset.normalized() * speed
	#var newAngle = atan2(offset.y, offset.x)
	##$ThePeek.rotation.y = newAngle
	#var tween = create_tween()
	#print(newAngle)
	#tween.tween_property($ThePeek, "rotation", Vector3(0, newAngle, 0), 0.25)
	#tween.tween_property($".", "velocity", newVelocity, 0.5)
	##velocity = newVelocity
	##move_and_slide()
	#
	#
	#
	if target != null:
		updateTargetLocation(target.global_position)
		pass
	pass # Replace with function body.


func _physics_process(delta):
	var currentLocation = global_position
	var nextLocation = navAgent.get_next_path_position()
	var offset = (nextLocation - currentLocation)
	var newVelocity = offset.normalized() * speed
	var newAngle = atan2(offset.x, offset.z)
	#$ThePeek.rotation.y = newAngle
	var tween = create_tween()
	#print(newAngle)
	tween.tween_property($ThePeek, "rotation", Vector3(0, newAngle, 0), 0.25)
	tween.tween_property($".", "velocity", newVelocity, 0.5)
	move_and_slide()
	pass


func updateTargetLocation(location):
	navAgent.set_target_position(location)
	
	pass


func _on_attack_area_body_entered(body):
	$ThePeek/AnimationPlayer.play("openMouth")
	pass # Replace with function body.
