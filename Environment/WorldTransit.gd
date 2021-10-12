extends Control

onready var label := $Label
onready var world := $World
onready var timer := $Timer

onready var label_text: String = label.text
var dots := "."
var ticks := 0
var max_ticks := 2

func _ready():
	label.text = label_text % [dots]
	world.text %= Master.world_num
	_anim_init()

func _anim_init():
	for anim in $Animations.get_children():
		var animPlayer = anim.get_node("AnimationPlayer")
		animPlayer.play(anim.name)

func _on_Timer_timeout():
	if dots != "...":
		dots += "."
	else:
		dots = ""
		ticks += 1
	label.text = label_text % [dots]
	
	if ticks == max_ticks:
		Transit.change_scene(Master.next_world)
		# increment ticks so 'change_scene' cannot be called again
		ticks += 1
