extends State

onready var ghostTimer := $GhostTimer
onready var ghostTween := $GhostTween

func _handle_input(event: InputEvent):
	if event.is_action_pressed("dash") && owner.dashBar.value >= 50:
		owner.change_state("Dash")

func _enter_state():
	owner.play_anim("Dash")
	ghostTimer.start()
	owner.dash()

func _state_logic():
	owner.velocity.y = -20
	
	if abs(int(owner.velocity.x)) <= owner.SPEED:
		if owner.is_on_floor():
			owner.change_state("Move")
		else:
			owner.change_state("Fall")

func _exit_state():
	ghostTimer.stop()

func _on_GhostTimer_timeout():
	var ghost = owner.sprite.duplicate()
	ghost.global_position = owner.sprite.global_position
	ghost.z_index = -1
	get_tree().current_scene.add_child(ghost)
	start_tween(ghost)

func start_tween(ghost: Sprite):
	ghostTween.interpolate_property(ghost, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.6, Tween.TRANS_SINE, Tween.EASE_OUT)
	ghostTween.start()

func _on_tween_completed(object: Object, _key):
	object.queue_free()
