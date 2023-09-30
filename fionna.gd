extends CharacterBody2D
var speed = 400
var acceleration = 10000
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $Pivot
@onready var sprite_2d = $Pivot/Sprite2D



func _ready() -> void:
	animation_tree.active = true
	

#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("up_movement"):
#		animation_player.play("up_movement")
#	if event.is_action_pressed("down_movement"):
#		animation_player.play("down_movement")
#	if event.is_action_pressed("left"):
#		animation_player.play("x_movement")
#	if event.is_action_pressed("right"):
#		animation_player.play("x_movement")

func _physics_process(delta: float) -> void:
	var move_inputx = Input.get_axis("left","right")
	var move_inputy = Input.get_axis("up_movement", "down_movement")
	
	velocity.x = move_toward(velocity.x, speed*move_inputx, acceleration * delta)
	velocity.y = move_toward(velocity.y, speed*move_inputy, acceleration*delta)
	
	#velocity = Vector2(Input.get_axis("left", "right"),Input.get_axis("up_movement", "down_movement"))
	#velocity = velocity.normalized()*speed
	#velocity.x = move_toward(velocity.x, speed*move_input, acceleration * delta)
	move_and_slide()
	
	#animation
	if velocity.x != 0:
		pivot.scale.x = sign(velocity.x)
	
	if abs(velocity.x) > 10 or move_inputx:
		playback.travel("x_movement")
	else:
		playback.travel("idle")
	if velocity.y < 0:
		playback.travel("up_movement")
	if velocity.y > 0:
		playback.travel("down_movement")
#	velocity = Vector2(Input.get_axis("left", "right"),Input.get_axis("up_movement", "down_movement"))
#	velocity = velocity.normalized()*speed
#	move_and_slide()
	
	
#	if abs(velocity.x)>0:
#		playback.travel("movement_x")
#	else:
#		playback.travel("idle")
#
#	if velocity.y<0:
#		playback.travel("up_movement")
#	else:
#		playback.travel("idle")
		
#	if velocity.y>0:
#		playback.travel("down_movement")
#	else:
#		playback.travel("idle")
