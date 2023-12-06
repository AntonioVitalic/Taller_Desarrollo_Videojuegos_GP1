extends MarginContainer
@onready var main_menu = $"."
@onready var panel_container = $"../PanelContainer"




func _on_back_pressed():
	main_menu.hide()
	panel_container.show()
	





func _on_volume_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/Volume_options.tscn")
