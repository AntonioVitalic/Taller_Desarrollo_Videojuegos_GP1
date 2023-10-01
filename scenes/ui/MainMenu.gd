extends MarginContainer

@onready var start_button_mm = %StartButtonMM
@onready var settings_button_mm = %SettingsButtonMM
@onready var credits_button_mm = %CreditsButtonMM
@onready var quit_button_mm = %QuitButtonMM

func _ready() -> void:
	start_button_mm.pressed.connect(_on_start_pressed)
	quit_button_mm.pressed.connect(_on_quit_pressed)
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/backgroundScenes/level1_1.tscn")
	
func _on_settings_pressed():
	pass
	
func _on_credits_pressed():
	pass
	
func _on_quit_pressed():
	get_tree().quit()
