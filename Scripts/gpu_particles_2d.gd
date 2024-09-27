extends Node2D

var parallax_strength = 1  # Adjust this to control how strong the parallax effect is

func _process(delta):
	if get_viewport().get_camera_2d() != null:
		var camera_pos = get_viewport().get_camera_2d().global_position
		global_position = camera_pos * parallax_strength
