extends Area2D

export (String, FILE, "*.tscn") var scene
export (bool) var new_world

func _on_Door_body_entered(body: Node):
	if body.name == "Player":
		if new_world:
			Master.next_world = scene
			Transit.change_scene("res://Environment/WorldTransit.tscn")
		else:
			Transit.change_scene(scene, "Hole", 0.4)
