class_name NetworkManager
extends Node


const DOUBLE: Array = [8, "d"]
const FLOAT: Array = [4, "f"]
const INT: Array = [4, "i"]
const BOOL: Array = [1, "b"]

var Peer: PacketPeerUDP = PacketPeerUDP.new()

var _unix_time: float
var _face_id: int
var _screen_width: float
var _screen_height: float
var _right_eye: float
var _left_eye: float
var _detected_face: int
var _pnp_error: float
var _quaternion: Vector4
var _euler: Vector3
var _translation: Vector3
var _y_packets: Array[float]
var _x_packets: Array[float]
var _has_packets: bool

var NewThread: Thread


func get_unix_time() -> float:
	return _unix_time


func get_face_id() -> int:
	return _face_id


func get_screen_width() -> float:
	return _screen_width


func get_screen_height() -> float:
	return _screen_height


func get_right_eye() -> float: 
	return _right_eye


func is_right_eye_open() -> bool:
	return _right_eye > 0.3


func get_left_eye() -> float:
	return _left_eye


func is_left_eye_open() -> bool:
	return _left_eye > 0.3


func has_detected_face() -> bool:
	return _detected_face as bool


func is_mouth_open() -> bool:
	var point_27: Vector2 = Vector2(_x_packets[27], _y_packets[27])
	var point_28: Vector2 = Vector2(_x_packets[28], _y_packets[28])
	var point_60: Vector2 = Vector2(_x_packets[60], _y_packets[60])
	var point_65: Vector2 = Vector2(_x_packets[65], _y_packets[65])
	return true


func get_pnp_error() -> float: 
	return _pnp_error


func get_quaternion() -> Vector4:
	return _quaternion


func get_euler() -> Vector3:
	return _euler


func get_translation() -> Vector3:
	return _translation


func get_x_packets() -> Array[float]:
	return _x_packets


func get_y_packets() -> Array[float]:
	return _y_packets


func has_packet() -> bool:
	return Peer.get_available_packet_count() > 0


func start_osf() -> void:
	NewThread = Thread.new()
	NewThread.start(Callable(self, '_thread'))


func _thread() -> void:
	# Starts new python3-thread of open_see_face
	# Width and height are very dependend on how big a processor you have
	# Model 2 and Model 3 are the most performan
	OS.execute('python3', [
		'open_see_face/OpenSeeFace-master/facetracker.py', 
		'-p 4433', 
		'-m 2',
		'-W 960',
		'-H 540',
		"-v 2"
		])


func _init() -> void:
	_connect_to_port()


func _connect_to_port() -> void:
	Peer.bind(4433)


func _process(_delta: float) -> void:
	if Peer.get_available_packet_count() > 0:
		_decode_packet(Peer.get_packet())
		_has_packets = true
	else:
		_has_packets = false

	#_print_debug()


func _decode_packet(packet: PackedByteArray) -> void:
	_unix_time = _decode_bytes(packet, DOUBLE)[0]
	_face_id = _decode_bytes(packet, INT)[0]
	_screen_width = _decode_bytes(packet, FLOAT)[0]
	_screen_height = _decode_bytes(packet, FLOAT)[0]
	_right_eye = _decode_bytes(packet, FLOAT)[0]
	_left_eye = _decode_bytes(packet, FLOAT)[0]
	_detected_face = _decode_bytes(packet, BOOL)[0]
	_pnp_error = _decode_bytes(packet, FLOAT)[0]

	for i in range(4):
		_quaternion[i] = _decode_bytes(packet, FLOAT)[0]

	for i in range(3):
		_euler[i] = _decode_bytes(packet, FLOAT)[0]

	for i in range(3):
		_translation[i] = _decode_bytes(packet, FLOAT)[0]

	#This deletes the unused c packet
	for i in range(68):
		_decode_bytes(packet, FLOAT)

	var t: bool = false
	_x_packets.clear()
	_y_packets.clear()

	for i in range(136):
		if t:
			_y_packets.append(_decode_bytes(packet, FLOAT)[0])
		else:
			_x_packets.append(_decode_bytes(packet, FLOAT)[0])

		t = not t


func _decode_bytes(packet: PackedByteArray, type: Array) -> Array:
	var tmp_value: PackedByteArray
	var value: Array = [0]

	for i in range(type[0]):
		tmp_value.append(packet[i])

	match type[1]:
		DOUBLE[1]:
			value[0] = tmp_value.decode_double(0)
		FLOAT[1]:
			value[0] = tmp_value.decode_float(0)
		INT[1]:
			value[0] = tmp_value.decode_s32(0)
		BOOL[1]:
			value[0] = tmp_value[0]

	for i in range(type[0]):
		packet.remove_at(0)

	return value


func _print_debug() -> void:
	print_rich("[color=red] === Packet Start === [/color]")
	print("Unix Time: " + str(_unix_time))
	print("Face id: " + str(_face_id))
	print("Screen Width: " + str(_screen_width))
	print("Screen Height: " + str(_screen_height))
	print("Right Eye: " + str(_right_eye))
	print("Left Eye: " + str(_left_eye))
	print("Detected Face: " + str(_detected_face))
	print("PNP error: " + str(_pnp_error))
	print("Quaternion: " + str(_quaternion))
	print("Euler: " + str(_euler))
