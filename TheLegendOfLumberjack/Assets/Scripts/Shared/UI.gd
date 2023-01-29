extends CanvasLayer

onready var heart1 = $Heart1
onready var heart2 = $Heart2
onready var heart3 = $Heart3
onready var coinLabel = $Label

func _ready():
	coinLabel.text = String("%04d" % 0);

func setHearts(hearts = 0):
	print(hearts)
	
	if hearts == 3:
		heart1.set_frame(0)
		heart2.set_frame(0)
		heart3.set_frame(0)
		return

	if hearts >= 2.5:
		heart1.set_frame(0)
		heart2.set_frame(0)
		heart3.set_frame(1)
		return

	if hearts >= 2:
		heart1.set_frame(0)
		heart2.set_frame(0)
		heart3.set_frame(2)
		return

	if hearts >= 1.5:
		heart1.set_frame(0)
		heart2.set_frame(1)
		heart3.set_frame(2)
		return

	if hearts >= 1:
		heart1.set_frame(0)
		heart2.set_frame(2)
		heart3.set_frame(2)
		return
		
	if hearts >= .5:
		heart1.set_frame(1)
		heart2.set_frame(2)
		heart3.set_frame(2)
		return

func setCoins(coins):
	coinLabel.text = String("%04d" % coins);
	
