extends KinematicBody2D

onready var sprite := $Sprite
onready var animPlayer := $AnimationPlayer
onready var dashBar := $DashBar

onready var sprite_size: Vector2 = sprite.texture.get_size()

# MOVEMENT
var GRAVITY := 28
var JUMP_FORCE := 450
var SPEED := 210
var DASH_SPEED := SPEED * 7
var ACCEL := 0.4

var velocity := Vector2.ZERO
var dir := 0.0

# STATES
var states := {}
var state := ""

# INITIALIZATION
func _ready():
	_states_init()

func _states_init():
	for _state in $States.get_children():
		states[_state.name] = _state
	state = "Move"

func _unhandled_input(event: InputEvent):
	states[state]._handle_input(event)

# PHYSICS
func _physics_process(_delta):
	apply_dir()
	apply_gravity()
	apply_velocity()
	velocity = move_and_slide(velocity, Vector2.UP)
	states[state]._state_logic()

func apply_dir():
	dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if dir != 0:
		sprite.scale.x = dir

func apply_gravity():
	velocity.y += GRAVITY

func apply_velocity():
	velocity.x = lerp(velocity.x, SPEED * dir, ACCEL)

# INPUT EVENTS
func dash():
	velocity.x += DASH_SPEED * sprite.scale.x
	dashBar.start_cooldown()

func jump():
	velocity.y = -JUMP_FORCE

# STATES HANDLER
func change_state(new_state: String):
	states[state]._exit_state()
	states[new_state]._enter_state()
	state = new_state

# ANIMATIONS HANDLER
func play_anim(anim: String):
	if !can_play(anim):
		return
	animPlayer.play(anim)

# check current animation to play new animation
func can_play(anim: String) -> bool:
	var curr: String = animPlayer.current_animation
	match curr:
		"Jump":
			return !(anim == "Float")
		"Land":
			return !(anim == "Idle" || anim == "Run")
	return true
