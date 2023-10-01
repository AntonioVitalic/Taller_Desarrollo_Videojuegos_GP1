extends Node2D
@onready var fred = $Fred
@onready var top_left = $margins/top_left
@onready var bottom_right = $margins/bottom_right

# Called when the node enters the scene tree for the first time.
func _ready():
	fred.set_camera_margins(top_left.global_position, bottom_right.global_position)
