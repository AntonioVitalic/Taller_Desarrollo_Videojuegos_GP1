extends MarginContainer

@onready var resume_button_pm = %ResumeButtonPM
@onready var restart_button_pm = %RestartButtonPM
@onready var settings_button_pm = %SettingsButtonPM
@onready var menu_button_pm = %MenuButtonPM
@onready var quit_button_pm = %QuitButtonPM

@export var main_menu: PackedScene

func _ready() -> void:
	resume_button_pm.pressed.connect(_on_resume_pressed)
	restart_button_pm.pressed.connect(_on_restart_pressed)
	settings_button_pm.pressed.connect(_on_settings_pressed)
	menu_button_pm.pressed.connect(_on_menu_pressed)
	quit_button_pm.pressed.connect(_on_quit_pressed)
	
	hide()
	
func _input(event: InputEvent) -> void:
	if event. is_action_pressed("pause"):
		visible = !visible
		get_tree().paused = visible
	
func _on_resume_pressed():
	hide()

func _on_restart_pressed():
	get_tree().reload_current_scene()
	
func _on_settings_pressed():
	pass
	
func _on_menu_pressed():
	if not main_menu:
		return
	get_tree().change_scene_to_packed(main_menu)
	
func _on_quit_pressed():
	get_tree().quit()
