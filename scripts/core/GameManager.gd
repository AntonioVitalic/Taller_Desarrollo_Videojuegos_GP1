extends Node

var player : Fred
var coins : int
var permanent_coins : int
signal gained_coins(int)

func gain_coins(coins_gained:int):
	coins += coins_gained
	emit_signal("gained_coins", coins_gained)
