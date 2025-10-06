class_name Debug
extends Node2D


const POINT_SCENE: PackedScene = preload("res://debug/point.tscn")

var Points: Array[ColorRect]

@onready var LeftEye: ColorRect = $LeftEye
@onready var RightEye: ColorRect = $RightEye
@onready var Line: Line2D = $EyeLine
@onready var PointCollection: Node2D = $Points
@onready var NetworkManagerInstance: NetworkManager = $NetworkManager


func _ready() -> void:
	NetworkManagerInstance.start_osf()

	for i in range(68):
		var Point: ColorRect = POINT_SCENE.instantiate()
		Point.get_child(0).text = str(i)
		Points.append(Point)
		PointCollection.add_child(Point)


func _process(_delta: float) -> void:
	if NetworkManagerInstance.has_packet():
		await get_tree().process_frame

		var x_packets: Array[float] = NetworkManagerInstance.get_x_packets()
		var y_packets: Array[float] = NetworkManagerInstance.get_y_packets()
		var right_eye: float = NetworkManagerInstance.get_right_eye()
		var left_eye: float = NetworkManagerInstance.get_left_eye()
		print(x_packets[0])

		for i in range(68):
			Points[i].position = Vector2(x_packets[i], y_packets[i])

		Line.points[0].x = Points[37].position.x
		Line.points[0].y = Points[37].position.y

		Line.points[1].x = Points[18].position.x
		Line.points[1].y = Points[18].position.y

		if right_eye < 0.5:
			RightEye.self_modulate = Color8(255, 0, 0)
		else:
			RightEye.self_modulate = Color8(255, 255, 255)

		if right_eye < 0.5:
			LeftEye.self_modulate = Color8(255, 0, 0)
		else:
			LeftEye.self_modulate = Color8(255, 255, 255)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shift"):
		get_tree().change_scene_to_packed(
			load("res://titlescreen/titlescreen.tscn")
		)
