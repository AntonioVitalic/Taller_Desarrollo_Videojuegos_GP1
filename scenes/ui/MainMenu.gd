extends MarginContainer

@onready var start_button_mm = %StartButtonMM
@onready var settings_button_mm = %SettingsButtonMM
@onready var credits_button_mm = %CreditsButtonMM
@onready var quit_button_mm = %QuitButtonMM

func _ready() -> void:
	quit_button_mm.pressed.connect(_on_quit_pressed)
	
	
func _on_quit_pressed():
	get_tree().quit()
