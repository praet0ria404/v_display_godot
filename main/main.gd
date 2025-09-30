class_name Main
extends Node2D


@onready var NetworkManagerInstance: NetworkManager = $NetworkManager

@onready var StartInstance: Start = $Start


func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	StartInstance.start_tracking.connect( _start_tracking)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shift"):
		get_tree().change_scene_to_packed(
			load("res://titlescreen/titlescreen.tscn")
		)


func _start_tracking() -> void:
	print("Tracking should be started here")
	NetworkManagerInstance.start_osf()


func _physics_process(_delta: float) -> void:
	print(NetworkManagerInstance.get_unix_time())


