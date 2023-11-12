extends CharacterBody2D

var speed = 100
var acceleration = 1000
var gravity = 400

@onready var pivot = $Pivot
@onready var ray_cast_2d = $Pivot/RayCast2D


var direction = Vector2.RIGHT

func _physics_process(delta):
	velocity.x = move_toward(velocity.x, pivot.scale.x*speed, acceleration*delta)
	if not is_on_floor():
		velocity.y += gravity*delta
	if is_on_floor() and not ray_cast_2d.is_colliding():
		pivot.scale.x *= -1
		velocity.x *=-1
	move_and_slide()
	


func _on_area_2d_body_entered(body):
	if body.is_in_group("fred") or body.is_in_group("fly"):
		get_tree().reload_current_scene()
