extends Control

@onready var ok_button = $PanelContainer/MarginContainer/VBoxContainer/ok_button

func _on_ok_button_pressed():
	queue_free()
