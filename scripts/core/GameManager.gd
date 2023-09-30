extends Node

var current_cp : Balloon
var fred : Fred
var coins
signal gained_coins(int)




func  gain_coins(coins_gained:int):
	coins += coins_gained
	emit_signal("gained_coins", coins_gained)
	print(coins)
