
extends Node2D
@onready var tip = $Tip
var direction := Vector2(0,0)	# The direction in which the tongue was shot
@onready var links = $Links
@onready var fionna = $Fionna
@onready var timer = $Timer
signal is_hooked(value)


const SPEED = 2000	# The speed with which the tongue moves
const MAX_RANGE = 300 # Adjust this value as needed

var flying = false	# Whether the tongue is moving through the air
var hooked = false	# Whether the tongue has connected to a wall
var fly
var target = Vector2(0,0)
var moving = false

# shoot() shoots the tongue in a given direction
func shoot(dir: Vector2) -> void:
	direction = dir
	look_at(direction)
	flying = true
	target = get_global_mouse_position()
	timer.start()

# release() the tongue
func release() -> void:
	flying = false	# Not flying anymore	
	hooked = false	# Not attached anymore
	emit_signal("is_hooked", false)
	timer.stop()

func _physics_process(delta):
	
	if flying:
		var distance_to_target = global_position.distance_to(target)
		if distance_to_target > MAX_RANGE:
			target = global_position + (target - global_position).normalized() * MAX_RANGE
		tip.global_position = tip.global_position.move_toward(target, SPEED * delta)
	elif hooked:
		tip.global_position = fly.global_position
		if moving:
			release()
	else:
		tip.global_position = global_position
		
	links.points[1] = tip.position



func _on_collision_area_body_entered(body):
	if (body is Fionna) and (not moving):
		flying = false
		hooked = true
		emit_signal("is_hooked", true)
		fly = body


func _on_fionna_is_moving(value):
	moving = value
func _on_timer_timeout():
	release()
	print("¡La lengua estuvo agarrada por mucho tiempo!")
