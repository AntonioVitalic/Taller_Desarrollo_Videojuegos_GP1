
extends Node2D
@onready var tip = $Tip
var direction := Vector2(0,0)	# The direction in which the tongue was shot
@onready var links = $Links



const SPEED = 2000	# The speed with which the tongue moves

var flying = false	# Whether the tongue is moving through the air
var hooked = false	# Whether the tongue has connected to a wall
var fly
var target = Vector2(0,0)

# shoot() shoots the tongue in a given direction
func shoot(dir: Vector2) -> void:
	direction = dir
	look_at(direction)
	flying = true
	target = get_global_mouse_position()

# release() the tongue
func release() -> void:
	flying = false	# Not flying anymore	
	hooked = false	# Not attached anymore

func _physics_process(delta):
	if flying:
		tip.global_position = tip.global_position.move_toward(target, SPEED*delta)
	elif hooked:
		tip.global_position = fly.global_position
	else: 
		tip.global_position = global_position
	links.points[1] = tip.position


func _on_collision_area_body_entered(body):
	if body is Fionna:
		flying = false
		hooked = true
		fly = body
