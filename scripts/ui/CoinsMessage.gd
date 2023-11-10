extends MarginContainer

@onready var ok_button = $PanelContainer/MarginContainer/VBoxContainer/ok_button

# Called when the node enters the scene tree for the first time.
func _ready():
	ok_button.pressed.connect(_hide_message)


func _hide_message():
	hide()
