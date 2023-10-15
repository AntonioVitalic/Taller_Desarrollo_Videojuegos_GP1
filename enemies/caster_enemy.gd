extends StaticBody2D

@export var bullet : PackedScene
var abletoshoot :bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $RayCast2D.is_colliding():
		var obj = $RayCast2D.get_collider()
		if  obj.is_in_group("fly") and abletoshoot:
			abletoshoot = false
			$Timer.start()
			shoot()


func shoot():
	var newbullet = bullet.instantiate()
	newbullet.global_position = $"Spawn-bullet".global_position
	get_parent().add_child(newbullet)
	


func _on_timer_timeout():
	abletoshoot = true
