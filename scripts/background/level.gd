extends Node2D
@onready var fred = $Fred
@onready var top_left = $margins/top_left
@onready var bottom_right = $margins/bottom_right
var moving_platform
var current_level = [0, 0] # Stage, level
var num_level = 2 # Number of levels per stage

@onready var next_level_platform_scene = preload("res://scenes/backgroundScenes/next_level_platform.tscn")


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
	# Get current stage,level
	var file_name = get_tree().get_current_scene().get_name().split("_")
	current_level[0] = file_name[1] # Stage
	current_level[1] = file_name[2] # Level
	
	fred.set_camera_margins(top_left.global_position, bottom_right.global_position)
	level_with_moving_platforms()

	Events.all_coins_collected.connect(show_next_level_platform)

func show_next_level_platform():
	var next_level_platform = next_level_platform_scene.instantiate()
	next_level_platform.position = Vector2(1217, 648)
	add_child(next_level_platform)
