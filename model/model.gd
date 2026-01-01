class_name Model
extends Node3D


enum EyebrowStates {
	RESTING = 0,
	RAISED = 1,
}

enum MouthStates {
	RESTING = 0,
	OPENED = 1,
}


@onready var Face: Sprite3D = $Face
@onready var LeftEye: Sprite3D = $Face/LeftEye
@onready var RightEye: Sprite3D = $Face/RightEye
@onready var LeftEyebrow: Sprite3D = $Face/LeftEyebrow
@onready var RightEyebrow: Sprite3D = $Face/RightEybrow
@onready var Mouth: Sprite3D = $Face/Mouth


#var left_eyebrow_state: EyebrowStates
#var right_eyebrow_state: EyebrowStates


func set_right_eye(frame: int) -> void:
	LeftEye.frame = frame


func set_left_eye(frame: int) -> void:
	RightEye.frame = frame


func set_left_eyebrow_state(state: EyebrowStates) -> void:
	LeftEyebrow.frame = int(state)


func set_right_eyebrow_state(state: EyebrowStates) -> void:
	RightEyebrow.frame = int(state)


func set_mouth_state(state: MouthStates) -> void:
	Mouth.frame = int(state)

