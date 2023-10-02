extends CharacterBody2D
class_name Fred

const JUMP_FORCE = 1550			# Force applied on jumping
const MOVE_velocity = 500			# velocity to walk with
const GRAVITY = 60				# Gravity applied every second
const MAX_velocity = 2000			# Maximum velocity the player is allowed to move
const FRICTION_AIR = 0.95		# The friction while airborne
const FRICTION_GROUND = 0.85	# The friction while on the ground
const Tongue_PULL = 105
@onready var camera= $Camera2D

var Tongue_velocity := Vector2(0,0)
var can_jump = false			# Whether the player used their air-jump


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			# We clicked the mouse -> shoot()
			$Tongue.shoot(event.position - get_viewport().size * 0.5)
		else:
			# We released the mouse -> release()
			$Tongue.release()

# This function is called every physics frame
func _physics_process(_delta: float) -> void:
	# Walking

	# Falling
	velocity.y += GRAVITY

	# Hook physics
	if $Tongue.hooked:
		# `to_local($Tongue.tip).normalized()` is the direction that the Tongue is pulling
		Tongue_velocity = to_local($Tongue.tip).normalized() * Tongue_PULL
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

