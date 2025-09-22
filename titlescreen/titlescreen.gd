class_name Titlescreen
extends Node2D


const MAIN_SCENE: PackedScene = preload("res://main/main.tscn")
const DEBUG_SCENE: PackedScene = preload("res://debug/debug.tscn")
const CONFIG_SCENE: PackedScene = preload("res://config/config.tscn")

enum {
	MODEL = 0,
	DEBUG = 1,
	CONFIG = 2,
	QUIT = 3,
}

@onready var Buttons: Array[TitlescreenButton] = [
	$Buttons/TitlescreenButton1,
	$Buttons/TitlescreenButton2,
	$Buttons/TitlescreenButton3,
	$Buttons/TitlescreenButton4,
]


func _ready() -> void:
	_display()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		if GlobalMain.menue_index > 0:
			GlobalMain.menue_index -= 1
		else:
			GlobalMain.menue_index = 3
	elif event.is_action_pressed("move_down"):
		if GlobalMain.menue_index < 3:
			GlobalMain.menue_index += 1
		else:
			GlobalMain.menue_index = 0
	elif event.is_action_pressed("start"):
		_act(GlobalMain.menue_index)

	_display()


func _display() -> void:
	for i in range(len(Buttons)):
		if i == GlobalMain.menue_index:
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
			get_tree().change_scene_to_packed(CONFIG_SCENE)
		QUIT:
			get_tree().quit()
