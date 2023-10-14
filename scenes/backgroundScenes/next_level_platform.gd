extends Node2D
@onready var countdown = $Platform/countdown
@onready var animation_player = $Platform/AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _ready():
	pass

# Choose the animation to play
func animation(animation):
	$AnimationPlayer.play(animation)


func _on_area_2d_body_entered(body):
	if body.name == "Fred":
		countdown.start()

func _on_area_2d_body_exited(body):
	if body.name == "Fred":
		countdown.stop()

func _on_countdown_timeout():
	animation_player.play("vertical")
