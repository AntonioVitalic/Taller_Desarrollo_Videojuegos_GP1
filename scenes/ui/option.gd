extends MarginContainer




func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/MainMenu.tscn")





func _on_volume_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/Volume_options.tscn")
