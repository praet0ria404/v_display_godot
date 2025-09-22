class_name Config
extends Node2D


@onready var SettingsList: Node2D = $Loads
@onready var Settings: Array[Label] = [
	$Loads/Label1,
	$Loads/Label2,
	$Loads/Label3,
	$Loads/Label4,
	$Loads/Label5,
	$Loads/Label6,
	$Loads/Label7,
	$Loads/Label8,
	$Loads/Label9,
	$Loads/Label10,
	$Loads/Label11,
	$Loads/Label12,
	$Loads/Label13,
	$Loads/Label14,
	$Loads/Label15,
]

var menue_index: int = 0


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shift"):
		get_tree().change_scene_to_packed(
			load("res://titlescreen/titlescreen.tscn")
		)
	elif event.is_action_pressed("move_down"):
		if menue_index < len(Settings) - 1:
			menue_index += 1
			if menue_index > 4:
				SettingsList.position.y -= 32
	elif event.is_action_pressed("move_up"):
		if menue_index > 0:
			menue_index -= 1
			if menue_index > 3:
				SettingsList.position.y += 32

	_display()


func _display() -> void:
	for i in range(len(Settings)):
		if i == menue_index:
			Settings[i].modulate = Color8(255, 0, 0)
		else:
			Settings[i].modulate = Color(255, 255, 255)
