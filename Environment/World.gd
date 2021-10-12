extends Node2D

onready var label := $UILayer/UI/Label
onready var player := $Player

onready var screensize := get_viewport_rect().size

func _ready():
	label.text = name

func _process(_delta):
	if player.position.y > screensize.y:
		Transit.reload_scene("Default", 0.25)
