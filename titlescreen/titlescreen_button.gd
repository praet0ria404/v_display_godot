class_name TitlescreenButton
extends Node2D


const TEXTURES: Array = [
	preload("res://titlescreen/start_button.png"),
	preload("res://titlescreen/wheel.png"),
	preload("res://titlescreen/repeat.png"),
	preload("res://titlescreen/quit.png"),
]

enum ButtonTypes {
	START_TRACKING = 0,
	DEBUG = 1,
	CONFIG = 2,
	QUIT = 3,
}

@export var ButtonType: ButtonTypes = ButtonTypes.START_TRACKING

@onready var Sprite: Sprite2D = $Sprite
@onready var Overlay: ColorRect = $Overlay
@onready var TextLabel: Label = $Label1
@onready var ShortcutLabel: Label = $Label2


func set_selected(selected: bool) -> void:
	if selected:
		Overlay.color = Color8(110, 110, 110, 83)
	else:
		Overlay.color = Color8(255, 255, 255, 0)


func _ready() -> void:
	match ButtonType: 
		ButtonTypes.START_TRACKING:
			TextLabel.text = "Start Tracking"
			ShortcutLabel.text = "[F]"
			Overlay.color = Color8(110, 110, 110, 83)
		ButtonTypes.DEBUG:
			TextLabel.text = "Debug"
			ShortcutLabel.text = "[E]"
		ButtonTypes.CONFIG:
			TextLabel.text = "Config"
			ShortcutLabel.text = "[C]"
		ButtonTypes.QUIT:
			TextLabel.text = "Quit"
			ShortcutLabel.text = "[Q]"
	
	Sprite.texture = TEXTURES[ButtonType as int]


