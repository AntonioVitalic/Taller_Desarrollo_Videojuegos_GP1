extends CharacterBody2D
var speed = 200
func _physics_process(delta):
	velocity = Vector2(Input.get_axis("ui_left", "ui_right"),Input.get_axis("ui_up", "ui_down"))
	velocity = velocity.normalized()*speed
	move_and_slide()
	
