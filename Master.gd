extends Node

var world_num := 0
var next_world := "" setget set_next_world, get_next_world

func set_next_world(new_scene: String):
	world_num += 1
	next_world = new_scene

func get_next_world():
	return next_world
