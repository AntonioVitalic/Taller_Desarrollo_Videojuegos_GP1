extends CharacterBody2D

const JUMP_FORCE = 1550			# Force applied on jumping
const MOVE_SPEED = 500			# Speed to walk with
const GRAVITY = 60				# Gravity applied every second
const MAX_SPEED = 2000			# Maximum speed the player is allowed to move
const FRICTION_AIR = 0.95		# The friction while airborne
const FRICTION_GROUND = 0.85	# The friction while on the ground
const CHAIN_PULL = 105

var speed = Vector2(0,0)		# The speed of the player (kept over time)
var chain_speed := Vector2(0,0)
var can_jump = false			# Whether the player used their air-jump


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			# We clicked the mouse -> shoot()
			$Chain.shoot(event.position - get_viewport().size * 0.5)
		else:
			# We released the mouse -> release()
			$Chain.release()

# This function is called every physics frame
func _physics_process(_delta: float) -> void:
	# Walking
	var walk = (Input.get_action_strength("right") - Input.get_action_strength("left")) * MOVE_SPEED

	# Falling
	speed.y += GRAVITY

	# Hook physics
	if $Chain.hooked:
		# `to_local($Chain.tip).normalized()` is the direction that the chain is pulling
		chain_speed = to_local($Chain.tip).normalized() * CHAIN_PULL
		if chain_speed.y > 0:
			# Pulling down isn't as strong
			chain_speed.y *= 0.55
		else:
			# Pulling up is stronger
			chain_speed.y *= 1.65
		if sign(chain_speed.x) != sign(walk):
			# if we are trying to walk in a different
			# direction than the chain is pulling
			# reduce its pull
			chain_speed.x *= 0.7
	else:
		# Not hooked -> no chain speed
		chain_speed = Vector2(0,0)
	speed += chain_speed

	speed.x += walk		# apply the walking
	move_and_slide()	# Actually apply all the forces
	speed.x -= walk		# take away the walk speed again
	# ^ This is done so we don't build up walk speed over time

	# Manage friction and refresh jump and stuff
	speed.y = clamp(speed.y, -MAX_SPEED, MAX_SPEED)	# Make sure we are in our limits
	speed.x = clamp(speed.x, -MAX_SPEED, MAX_SPEED)
	var grounded = is_on_floor()
	if grounded:
		speed.x *= FRICTION_GROUND	# Apply friction only on x (we are not moving on y anyway)
		can_jump = true 				# We refresh our air-jump
		if speed.y >= 5:		# Keep the y-speed small such that
			speed.y = 5		# gravity doesn't make this number huge
	elif is_on_ceiling() and speed.y <= -5:	# Same on ceilings
		speed.y = -5

	# Apply air friction
	if !grounded:
		speed.x *= FRICTION_AIR
		if speed.y > 0:
			speed.y *= FRICTION_AIR

	# Jumping
	if Input.is_action_just_pressed("jump"):
		if grounded:
			speed.y = -JUMP_FORCE	# Apply the jump-force
		elif can_jump:
			can_jump = false	# Used air-jump
			speed.y = -JUMP_FORCE

