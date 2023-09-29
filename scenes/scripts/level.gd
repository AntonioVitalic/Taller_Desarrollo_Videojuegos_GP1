extends Node2D
@onready var fred = $Fred
@onready var sup_left = $margins/sup_left
@onready var inf_right = $margins/inf_right


# Called when the node enters the scene tree for the first time.
func _ready():
	fred.set_camera_margins(sup_left.global_position, inf_right.global_position)
	pass # Replace with function body.
