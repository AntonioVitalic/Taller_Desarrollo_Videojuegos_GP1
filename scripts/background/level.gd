extends Node2D
@onready var fred = $Fred
@onready var top_left = $margins/top_left
@onready var bottom_right = $margins/bottom_right
var moving_platform

# To check if current level has moving platforms in it
# adds moving platforms script
func level_with_moving_platforms():
	moving_platform = get_node("MovingPlatformHolder")
	if moving_platform:
		$MovingPlatformHolder/MovingPlatform/Platform/AnimationPlayer.play("horizontal")
		$MovingPlatformHolder/MovingPlatform2/Platform/AnimationPlayer.play("horizontal")
		$MovingPlatformHolder/MovingPlatform3/Platform/AnimationPlayer.play("vertical")
		$MovingPlatformHolder/MovingPlatform4/Platform/AnimationPlayer.play("horizontal")

# Called when the node enters the scene tree for the first time.
func _ready():
	fred.set_camera_margins(top_left.global_position, bottom_right.global_position)
	level_with_moving_platforms()
		
