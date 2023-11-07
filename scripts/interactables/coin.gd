extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Idle")


func _on_area_2d_area_entered(area):
	GameManager.gain_coins(1)
	queue_free()
	var coins = get_tree().get_nodes_in_group("Coins")
	if coins.size() == 1:
		Events.all_coins_collected.emit()
