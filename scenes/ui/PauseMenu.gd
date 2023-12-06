extends MarginContainer

@onready var resume_button_pm = %ResumeButtonPM
@onready var restart_button_pm = %RestartButtonPM
@onready var settings_button_pm = %SettingsButtonPM
@onready var menu_button_pm = %MenuButtonPM
@onready var quit_button_pm = %QuitButtonPM
@onready var volume_menu = $volumeMenu
@onready var panel_container = $PanelContainer

@export var main_menu: PackedScene

func _ready() -> void:
	resume_button_pm.pressed.connect(_on_resume_pressed)
	restart_button_pm.pressed.connect(_on_restart_pressed)
	settings_button_pm.pressed.connect(_on_settings_pressed)
	menu_button_pm.pressed.connect(_on_menu_pressed)
	quit_button_pm.pressed.connect(_on_quit_pressed)
	volume_menu.hide()
	hide()
	
func _input(event: InputEvent) -> void:
	if event. is_action_pressed("pause_menu"):
		visible = !visible
		get_tree().paused = visible
	
func _on_resume_pressed():
	hide()
	get_tree().paused = false

func _on_restart_pressed():
	GameManager.coins = 0
	get_tree().reload_current_scene()
	get_tree().paused = false
	
func _on_settings_pressed():
	volume_menu.show()
	panel_container.hide()
	
func _on_menu_pressed():
	GameManager.coins = 0
	get_tree().paused = false
	LevelManager.go_to_main_menu()
	
func _on_quit_pressed():
	get_tree().quit()
