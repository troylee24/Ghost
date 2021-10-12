extends TextureProgress

onready var tweenProgress := $TweenProgress
onready var bar1 := $Bar1
onready var bar2 := $Bar2

func start_cooldown():
	tweenProgress.interpolate_property(self, "value", value-50, 100, 5.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tweenProgress.start()

#set bar color based on TextureProgress value
func _process(_delta):
	if value < 50:
		fill_bars(false, false)
	elif value < 100:
		fill_bars(true, false)
	elif value == 100:
		fill_bars(true, true)

func fill_bars(fill_1: bool, fill_2: bool):
	if not fill_1 && not fill_2:
		bar1.modulate = Color.red
		bar2.modulate = Color.red
	elif fill_1 && not fill_2:
		bar1.modulate = Color.yellow
		bar2.modulate = Color.red
	elif fill_1 && fill_2:
		bar1.modulate = Color.green
		bar2.modulate = Color.green
	bar1.modulate.a = 0.6
	bar2.modulate.a = 0.6
