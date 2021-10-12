extends State

func _handle_input(event: InputEvent):
	if event.is_action_pressed("dash") && owner.dashBar.value >= 50:
		owner.change_state("Dash")
	elif event.is_action_pressed("jump"):
		owner.change_state("Jump")

func _state_logic():
	if owner.is_on_floor():
		if owner.dir != 0:
			owner.play_anim("Run")
		else:
			owner.play_anim("Idle")
	else:
		if owner.velocity.y > 0:
			owner.change_state("Fall")
