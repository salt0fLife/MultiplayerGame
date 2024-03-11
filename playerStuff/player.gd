extends CharacterBody3D

@export var MouseSensitivity := 5
const SPEED = 2
const sprintSpeed = 10
const JUMP_VELOCITY = 4.5
var singlePlayer = false
var sprinting = false
var interacting = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	if is_multiplayer_authority():
		set_camera()
		pass
	pass

func set_camera():
	$gasMaskGuy/Armature/Skeleton3D/BoneAttachment3D/Camera3D.current = true

func _ready():
	
	
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if is_multiplayer_authority() or singlePlayer:
			velocity.y = JUMP_VELOCITY
	
	if is_multiplayer_authority() or singlePlayer:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("left", "right", "up", "down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			if sprinting:
				$gasMaskGuy/legAnimatons.play("run")
				velocity.x = direction.x * sprintSpeed
				velocity.z = direction.z * sprintSpeed
				pass
			else:
				$gasMaskGuy/legAnimatons.play("walk")
				velocity.x = direction.x * SPEED
				velocity.z = direction.z * SPEED
				pass
		else:
			$gasMaskGuy/legAnimatons.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()

func _input(event):
	if is_multiplayer_authority() or singlePlayer:
		if event is InputEventMouseMotion:
			if is_multiplayer_authority() or singlePlayer:
				var TempRotation = rotation.x - event.relative.y /1000 * MouseSensitivity
				$cameraHandler.rotation.x += TempRotation
				$cameraHandler.rotation.x = clamp($cameraHandler.rotation.x, -1.2, 1.5)
				rotation.y -= event.relative.x /1000 * MouseSensitivity
	
		if Input.is_action_just_pressed("sprint"):
			sprinting = true
			pass
		if Input.is_action_just_released("sprint"):
			sprinting = false
			pass
	
		if Input.is_action_just_pressed("interact"):
			$gasMaskGuy/armAnimations.play("holdingOneHand")
			tryToInteract()
			interacting = true
			pass
		if Input.is_action_just_released("interact"):
			$gasMaskGuy/armAnimations.play("holdingTwoHands")
			interacting = false
			pass
	
		if Input.is_action_just_pressed("leanLeft"):
			get_tree().create_tween().tween_property($torsoHandler, "rotation", Vector3(0,0,0.5), 0.25)
			#$torsoHandler.rotation.z = 1
			pass
		if Input.is_action_just_released("leanLeft"):
			get_tree().create_tween().tween_property($torsoHandler, "rotation", Vector3(0,0,0), 0.25)
			#$torsoHandler.rotation.z = 0
			pass
		if Input.is_action_just_pressed("leanRight"):
			get_tree().create_tween().tween_property($torsoHandler, "rotation", Vector3(0,0,-0.5), 0.25)
			pass
		if Input.is_action_just_released("leanRight"):
			get_tree().create_tween().tween_property($torsoHandler, "rotation", Vector3(0,0,0), 0.25)
			pass
	pass

func die():
	if is_multiplayer_authority() or singlePlayer:
		MultiplayerHandler.dieAnimation()
		position = Vector3(0,0,0)
		pass
	
	pass

func tryToInteract():
	var hit = $gasMaskGuy/Armature/Skeleton3D/BoneAttachment3D/Camera3D/RayCast3D.get_collider()
	if hit != null and hit.has_method("interact"):
		hit.interact()
		pass
	pass
