extends CharacterBody2D
class_name Fred

const JUMP_FORCE = 1550			# Force applied on jumping
const MOVE_velocity = 500		# Velocity to walk with
const GRAVITY = 25				# Gravity applied every second
const MAX_velocity = 2000		# Maximum velocity the player is allowed to move
const FRICTION_AIR = 0.98		# The friction while airborne
const FRICTION_GROUND = 0.85	# The friction while on the ground
var tongue_PULL = 50
@onready var camera= $Camera2D
@onready var tongue = $Tongue

var Tongue_velocity := Vector2(0,0)
var can_jump = false			# Whether the player used their air-jump

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("shoot_tongue"):
			# We clicked the mouse -> shoot()
		if not tongue.hooked:
			tongue.shoot(get_global_mouse_position())
		tongue_PULL = 50
		
		if Input.is_action_pressed("lessen_tongue_pull"):
			tongue_PULL = tongue_PULL/2
	else:
	# We released the mouse -> release()
		tongue.release()

# This function is called every physics frame
func _physics_process(_delta: float) -> void:
	# Walking

	# Falling
	velocity.y += GRAVITY

	# Hook physics
	if tongue.hooked:
		# `to_local(tongue.tip).normalized()` is the direction that the Tongue is pulling
		Tongue_velocity = to_local(tongue.tip.global_position).normalized() * tongue_PULL
		if Tongue_velocity.y > 0:
			# Pulling down isn't as strong
			Tongue_velocity.y *= 0.55
		else:
			# Pulling up is stronger
			Tongue_velocity.y *= 1.65
	else:
		# Not hooked -> no Tongue velocity
		Tongue_velocity = Vector2(0,0)
	velocity += Tongue_velocity

	#move_and_slide(velocity, Vector2.UP)	# Actually apply all the forces
	move_and_slide()	# Actually apply all the forces
	# ^ This is done so we don't build up walk velocity over time

	# Manage friction and refresh jump and stuff
	velocity.y = clamp(velocity.y, -MAX_velocity, MAX_velocity)	# Make sure we are in our limits
	velocity.x = clamp(velocity.x, -MAX_velocity, MAX_velocity)
	var grounded = is_on_floor()
	if grounded:
		velocity.x *= FRICTION_GROUND	# Apply friction only on x (we are not moving on y anyway)
		can_jump = true 				# We refresh our air-jump
		if velocity.y >= 5:		# Keep the y-velocity small such that
			velocity.y = 5		# gravity doesn't make this number huge
	elif is_on_ceiling() and velocity.y <= -5:	# Same on ceilings
		velocity.y = -5

	# Apply air friction
	if !grounded:
		velocity.x *= FRICTION_AIR
		if velocity.y > 0:
			velocity.y *= FRICTION_AIR


func set_camera_margins(top_left, bottom_right):
	camera.limit_top = top_left.y
	camera.limit_bottom = bottom_right.y
	camera.limit_left = top_left.x
	camera.limit_right = bottom_right.x
