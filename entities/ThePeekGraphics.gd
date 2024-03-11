@tool
extends Node3D



@export var DistanceBeforeStep := 0.8
const stepTime := 0.05
var normal
var stepping = false
@onready var previousGlobalPos = global_position
@export var stepPredictionStrength := 10

func _process(delta):
	for raycast in $stepTargetHandler.get_children(false):
		raycast.force_raycast_update()
		var newStep = raycast.get_collision_point()
		normal = raycast.get_collision_normal()
		#print(normal)
		if newStep != null:
			#print("newstep = " + str(newStep))
			raycast.get_child(0).global_position = newStep
			pass
		pass
	
	
	
	#handles stepping next
	for index in $"../LegPositionHolder".get_child_count(false):
		var step = $"../LegPositionHolder".get_child(index)
		var currentPos = step.position
		var target = $stepTargetHandler.get_child(index).get_child(0)
		var targetPos = target.global_position
		var offset = currentPos - targetPos
		#print(abs(difference.x + difference.y + difference.z)/3)
		
		if abs(offset.x) + abs(offset.y) + abs(offset.z) > DistanceBeforeStep:
			#step here
			#print("stepping?")
			if index % 2 == 0:
				await get_tree().create_timer(randi_range(0, (stepTime*10))).timeout
				step(step, targetPos, normal)
			else:
				step(step, targetPos, normal)
				pass
			
			pass
		pass
	
	
	#handles predictive stepping
	
	if global_position != previousGlobalPos:
		var distanceMoved = previousGlobalPos - global_position
		$stepTargetHandler.position = distanceMoved * Vector3(-stepPredictionStrength, -stepPredictionStrength, -stepPredictionStrength)
		pass
	else:
		$stepTargetHandler.position = $stepTargetHandler.position * Vector3(0.5, 0.5, 0.5)
		
		
		pass
	previousGlobalPos = global_position
	
	
	pass

func step(object, targetPos, normal):
	stepping = true
	var halfway = (object.global_position + targetPos)/2
	var tween = create_tween()
	tween.EASE_IN
	normal = normal * Vector3(0.5, 0.5, 0.5)
	
	#tween.TRANS_BOUNCE
	tween.tween_property(object, "global_position", halfway + normal, stepTime)
	tween.tween_property(object, "global_position", targetPos, stepTime)
	await get_tree().create_timer(stepTime).timeout
	stepping = false
	
	pass
