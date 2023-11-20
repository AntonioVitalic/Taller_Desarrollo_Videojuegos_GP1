extends CanvasLayer

@onready var rich_text_label = $MarginContainer/RichTextLabel
@onready var scroll_bar: VScrollBar = rich_text_label.get_v_scroll_bar()

func _ready():
	scroll_bar.step = 0.01
	set_process(false)
	await get_tree().create_timer(1).timeout
	set_process(true)

func _process(delta):
	scroll_bar.value += 1.0
