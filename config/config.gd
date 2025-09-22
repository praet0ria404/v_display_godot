class_name Config 
extends Node2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shift"):
		get_tree().change_scene_to_packed(
			load("res://titlescreen/titlescreen.tscn")
		)
