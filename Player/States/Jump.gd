extends State

func _handle_input(event: InputEvent):
	if event.is_action_pressed("dash") && owner.dashBar.value >= 50:
		owner.change_state("Dash")

func _enter_state():
	owner.play_anim("Jump")
	owner.jump()

func _state_logic():
	if owner.velocity.y <= 0:
		owner.play_anim("Float")
	else:
		owner.change_state("Fall")
