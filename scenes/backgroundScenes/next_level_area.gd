extends Area2D

#@export var fred_spawn_location = Vector2.ZERO
@export_file var next_scene_path = ""

func _get_configuration_warnings():
	if next_scene_path == "":
		return "next_scene_path must be set for next_level to work"
	else:
		return ""


func _on_body_entered(body):
	GameManager.permanent_coins = GameManager.coins
	if get_tree().change_scene_to_file(next_scene_path) != OK:
		print("Error: Unavailable scene")
