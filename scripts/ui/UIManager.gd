extends CanvasLayer

func _ready():
	GameManager.gained_coins.connect(update_coin_display)

func update_coin_display(gained_coins):
	$CoinDisplay.text = str(GameManager.coins)
