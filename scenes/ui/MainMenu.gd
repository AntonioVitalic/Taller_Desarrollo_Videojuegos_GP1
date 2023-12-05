extends MarginContainer

@onready var start_button_mm = %StartButtonMM
@onready var settings_button_mm = %SettingsButtonMM
@onready var credits_button_mm = %CreditsButtonMM
@onready var quit_button_mm = %QuitButtonMM
@onready var howtoplay_button_mm =%HowToPlayButtonMM

func _ready() -> void:
	start_button_mm.pressed.connect(_on_start_pressed)
	quit_button_mm.pressed.connect(_on_quit_pressed)
	credits_button_mm.pressed.connect(_on_credits_pressed)
	
func _on_start_pressed():
	LevelManager.start_game()
	
	
func _on_credits_pressed():
	LevelManager.go_to_credits()

	
func _on_quit_pressed():
	get_tree().quit()


func _on_settings_button_mm_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/option.tscn")


func _on_how_to_play_button_mm_pressed():
	get_tree().change_scene_to_file("res://how_to_play.tscn")
