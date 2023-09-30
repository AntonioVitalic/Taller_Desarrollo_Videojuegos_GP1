extends Node2D
class_name Balloon

@export var spawnpoint = false
var activated = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if spawnpoint:
		activate()


func activate():
	GameManager.current_cp = self
	activated = true

func _on_area_2d_area_entered(area):
	if area.get_parent() is Fred:
		activate()
