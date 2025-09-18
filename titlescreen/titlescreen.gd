class_name Titlescreen
extends Node2D


const MAIN_SCENE: PackedScene = preload("res://main/main.tscn")
const DEBUG_SCENE: PackedScene = preload("res://debug/debug.tscn")

enum {
	MODEL = 0,
	DEBUG = 1,
	CONFIG = 2,
	QUIT = 3,
}

var titlescreen_index: int = 0

@onready var Buttons: Array[TitlescreenButton] = [
	$Buttons/TitlescreenButton1,
	$Buttons/TitlescreenButton2,
	$Buttons/TitlescreenButton3,
	$Buttons/TitlescreenButton4,
]


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		if titlescreen_index > 0:
			titlescreen_index -= 1
		else:
			titlescreen_index = 3
	elif event.is_action_pressed("move_down"):
		if titlescreen_index < 3:
			titlescreen_index += 1
		else:
			titlescreen_index = 0
	elif event.is_action_pressed("start"):
		_act(titlescreen_index)

	_display()


func _display() -> void:
	for i in range(len(Buttons)):
		if i == titlescreen_index:
			Buttons[i].set_selected(true)
		else:
			Buttons[i].set_selected(false)


func _act(index: int) -> void:
	match index:
		MODEL:
			get_tree().change_scene_to_packed(MAIN_SCENE)
		DEBUG:
			get_tree().change_scene_to_packed(DEBUG_SCENE)
		CONFIG:
			get_tree().change_scene_to_packed(MAIN_SCENE)
		QUIT:
			get_tree().quit()


