extends CharacterBody2D
class_name Fionna
var speed = 400
var acceleration = 10000
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $Pivot
@onready var sprite_2d = $Pivot/Sprite2D

signal is_moving(value)
var hooked = false
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
	
	if not hooked:
		velocity.x = move_toward(velocity.x, speed*move_inputx, acceleration * delta)
		velocity.y = move_toward(velocity.y, speed*move_inputy, acceleration*delta)
		move_and_slide()
	
	#animation
		if velocity.x != 0:
			pivot.scale.x = sign(velocity.x)
	
		if abs(velocity.x) > 10 or move_inputx:
			playback.travel("x_movement")
			emit_signal("is_moving", true)
		else:
			playback.travel("idle")
			emit_signal("is_moving", false)
		if velocity.y < 0:
			playback.travel("up_movement")
			emit_signal("is_moving", true)
		if velocity.y > 0:
			playback.travel("down_movement")
			emit_signal("is_moving", true)


func _on_tongue_is_hooked(value):
	hooked = value
