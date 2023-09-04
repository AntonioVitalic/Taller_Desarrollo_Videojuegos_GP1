extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const SWING_FORCE = 1000.0
const MAX_SWING_ANGLE = 60.0
var isSwinging = false
var swingAttachmentPoint = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# var velocity = Vector2()

func _physics_process(delta):
	# Handle input and tongue shooting
	if Input.is_action_just_pressed("shoot_tongue"):
		shootTongue(get_global_mouse_position())

	# Apply tongue swinging physics if swinging
	if isSwinging:
		var directSpaceState = PhysicsServer2D.space_get_direct_state(get_world_2d().space)
		var swingDirection = (swingAttachmentPoint - global_position).normalized()
		var swingForce = swingDirection * SWING_FORCE * delta
		directSpaceState.apply_impulse(global_position, swingForce)

		# Limit the swing angle to make it feel more realistic
		var currentAngle = swingDirection.angle_to(Vector2.UP)
		if abs(currentAngle) > MAX_SWING_ANGLE:
			isSwinging = false
			releaseTongue()

func shootTongue(targetPosition):
	if !isSwinging:
		var ray = RayCast2D.new()
		add_child(ray)
		
		# Configure the ray
		ray.enabled = true
		ray.global_position = global_position
		ray.look_at(targetPosition)
		
		if ray.is_colliding():
			var rayResult = ray.get_collision_point()
			isSwinging = true
			swingAttachmentPoint = rayResult
			swingAttachmentPoint.y = global_position.y  # Lock the Y coordinate
			
		
		# Remove the ray when done
		ray.queue_free()

func releaseTongue():
	isSwinging = false
