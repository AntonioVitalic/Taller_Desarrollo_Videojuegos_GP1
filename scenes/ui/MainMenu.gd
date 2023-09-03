extends MarginContainer

@onready var start_button_mm = %StartButtonMM
@onready var settings_button_mm = %SettingsButtonMM
@onready var credits_button_mm = %CreditsButtonMM
@onready var quit_button_mm = %QuitButtonMM

func _ready() -> void:
	quit_button_mm.pressed.connect(_on_quit_pressed)
	
<<<<<<< Updated upstream
=======
func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/backgroundScenes/level0.tscn")
	
func _on_settings_pressed():
	pass
	
func _on_credits_pressed():
	pass
>>>>>>> Stashed changes
	
func _on_quit_pressed():
	get_tree().quit()
