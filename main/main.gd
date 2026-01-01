class_name Main
extends Node2D


@onready var NetworkManagerInstance: NetworkManager = $NetworkManager
@onready var StartInstance: Start = $Start
@onready var MascotModel: Node3D = $MascotModel


func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	StartInstance.start_tracking.connect(_start_tracking)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shift"):
		get_tree().change_scene_to_packed(
			load("res://titlescreen/titlescreen.tscn")
		)


func _start_tracking() -> void:
	NetworkManagerInstance.start_osf()


func _process(_delta: float) -> void:
	if NetworkManagerInstance.has_packet():
		var euler_y: float = NetworkManagerInstance.get_euler().y
		var euler_z: float = NetworkManagerInstance.get_euler().z
		var left_eye: bool = NetworkManagerInstance.is_left_eye_open()
		var right_eye: bool = NetworkManagerInstance.is_right_eye_open()
		var x_packets: Array[float] = NetworkManagerInstance.get_x_packets()
		var y_packets: Array[float] = NetworkManagerInstance.get_y_packets()
		#var open_mouth: bool = NetworkManagerInstance.is_mouth_open()

		MascotModel.get_node("Face").rotation_degrees = Vector3(
			0,
			(euler_y/2),
			(euler_z - 90) / 2
		)

		if right_eye:
			MascotModel.set_right_eye(0)
		else: 
			MascotModel.set_right_eye(1)

		if right_eye:
			MascotModel.set_left_eye(0)
		else:
			MascotModel.set_left_eye(1)

		#MascotModel.get_node("Face/Mouth").frame = 1 if open_mouth else 0
