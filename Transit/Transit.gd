extends Control

onready var tween := $Tween
onready var curtain := $CanvasLayer/Curtain

const DEFAULT_DURATION := 1.0

func set_custom_effect(effect_name: String):
	curtain.material = load("res://Transit/Effects/%s.tres" % [effect_name])

func set_custom_color(color: Color):
	curtain.material.set_shader_param("color", color)
	
func fade(from: float, to: float, duration: float):
	tween.interpolate_property(curtain.material, "shader_param/intensity", from, to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func change_scene(new_scene: String, effect_name: String = "Default", duration: float = DEFAULT_DURATION):
	set_custom_effect(effect_name)
	
	var curr_scene := get_tree().current_scene.filename
	get_tree().paused = true
	
	fade(0.0, 1.0, duration)
	yield(tween, "tween_completed")
	
	var err := get_tree().change_scene(new_scene)
	if err:
		printerr("TRANSIT ERROR: Failed to change scene from '%s' to '%s'" % [curr_scene, new_scene])
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://World/Worlds/World 0-1.tscn")
	
	fade(1.0, 0.0, duration)
	yield(tween, "tween_completed")
	
	get_tree().paused = false

func reload_scene(effect_name: String = "Default", duration: float = DEFAULT_DURATION):
	set_custom_effect(effect_name)
	
	var curr_scene := get_tree().current_scene.filename
	get_tree().paused = true
	
	fade(0.0, 1.0, duration)
	yield(tween, "tween_completed")
	
	var err := get_tree().reload_current_scene()
	if err:
		printerr("TRANSIT ERROR: Failed to reload scene '%s'" % [curr_scene])
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://World/Worlds/World 0-1.tscn")
	
	fade(1.0, 0.0, duration)
	yield(tween, "tween_completed")
	
	get_tree().paused = false
