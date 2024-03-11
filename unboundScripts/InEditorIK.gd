
@tool
extends Skeleton3D

func _process(_delta):
	#forHead
	var targetRotation = $"../../../cameraHandler".rotation
	#print(targetRotation)
	#set_bone_pose_rotation(4, Quaternion(Vector3(0,0,0).direction_to(Vector3(0,0,1) + Vector3(0, targetRotation.x, 0)), 1))
	set_bone_pose_rotation(4 , Quaternion(Vector3(0,0,0).direction_to(Vector3(targetRotation.x, 0, 0)), -abs(targetRotation.x)))
	
	
	#forTorso
	var torsoTargetRotation = $"../../../torsoHandler".rotation
	#print(targetRotation)
	#set_bone_pose_rotation(4, Quaternion(Vector3(0,0,0).direction_to(Vector3(0,0,1) + Vector3(0, targetRotation.x, 0)), 1))
	set_bone_pose_rotation(2 , Quaternion(Vector3(0,0,0).direction_to(Vector3(0, 0, torsoTargetRotation.z - 0.01)), -abs(torsoTargetRotation.z + 0.01)))
	
	
	#fixed foot problem (kinda)
	#set_bone_pose_rotation(61 , Quaternion(Vector3(0,0,0).direction_to(Vector3(0, 0, targetRotation.x - 0.01)), -abs(targetRotation.x + 0.01)))
	
	pass
