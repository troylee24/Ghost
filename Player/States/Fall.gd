extends State

var float_speed := 10
var anti_gravity := false

func _handle_input(event):
	if event.is_action_pressed("dash") && owner.dashBar.value >= 50:
		owner.change_state("Dash")
	elif event.is_action_pressed("jump"):
		anti_gravity = true
	elif event.is_action_released("jump"):
		anti_gravity = false
	
func _enter_state():
	owner.play_anim("Fall")

func _state_logic():
	if anti_gravity:
		owner.velocity.y = float_speed
	
	if owner.is_on_floor():
		owner.play_anim("Land")
		owner.change_state("Move")

func _exit_state():
	anti_gravity = false

