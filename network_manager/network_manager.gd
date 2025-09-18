class_name NetworkManager


const DOUBLE: Array = [8, "d"]
const FLOAT: Array = [4, "f"]
const INT: Array = [4, "i"]
const BOOL: Array = [1, "b"]

var Peer: PacketPeerUDP = PacketPeerUDP.new()

var unix_time: float
var face_id: int
var screen_width: float
var screen_height: float
var right_eye: float
var left_eye: float
var detected_face: int
var pnp_error: float
var quaternion: Array
var euler: Array
var translation: Array
var y_packets: Array[float]
var x_packets: Array[float]
var has_packets: bool


func get_unix_time() -> float:
	return self.unix_time


func get_face_id() -> int:
	return self.face_id


func get_screen_width() -> float:
	return self.screen_width


func get_screen_height() -> float:
	return self.screen_height


func get_right_eye() -> float: 
	return self.right_eye


func get_left_eye() -> float:
	return self.left_eye


func has_detected_face() -> bool:
	return self.detected_face as bool


func get_pnp_error() -> float: 
	return self.pnp_error


func get_quaternion() -> Array[float]:
	return self.translation


func get_euler() -> Array[float]:
	return self.translation


func get_translation() -> Array[float]:
	return self.translation


func get_x_packets() -> Array[float]:
	return self.x_packets


func get_y_packets() -> Array[float]:
	return self.y_packets


func has_packet() -> bool:
	return Peer.get_available_packet_count() > 0


func _init() -> void:
	_connect_to_port()


func _connect_to_port() -> void:
	Peer.bind(4433)


func _process(_delta: float) -> void:
	if Peer.get_available_packet_count() > 0:
		_decode_packet(Peer.get_packet())
		has_packets = true
	else:
		has_packets = false

	_print_debug()


func _decode_packet(packet: PackedByteArray) -> void:
	unix_time = _decode_bytes(packet, DOUBLE)[0]

	face_id = _decode_bytes(packet, INT)[0]

	screen_width = _decode_bytes(packet, FLOAT)[0]
	
	screen_height = _decode_bytes(packet, FLOAT)[0]

	right_eye = _decode_bytes(packet, FLOAT)[0]

	left_eye = _decode_bytes(packet, FLOAT)[0]

	detected_face = _decode_bytes(packet, BOOL)[0]

	pnp_error = _decode_bytes(packet, FLOAT)[0]

	quaternion = [0.0, 0.0, 0.0, 0.0]
	for i in range(4):
		quaternion[i] = _decode_bytes(packet, FLOAT)[0]

	euler = [0.0, 0.0, 0.0]
	for i in range(3):
		euler[i] = _decode_bytes(packet, FLOAT)[0]

	translation = [0.0, 0.0, 0.0]
	for i in range(3):
		translation[i] = _decode_bytes(packet, FLOAT)[0]

	#This deletes the unused c packet
	for i in range(68):
		_decode_bytes(packet, FLOAT)

	var t: bool = false

	for i in range(136):
		if t:
			y_packets.append(_decode_bytes(packet, FLOAT)[0])
		else:
			x_packets.append(_decode_bytes(packet, FLOAT)[0])

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
	print("Unix Time: " + str(unix_time))
	print("Face id: " + str(face_id))
	print("Screen Width: " + str(screen_width))
	print("Screen Height: " + str(screen_height))
	print("Right Eye: " + str(right_eye))
	print("Left Eye: " + str(left_eye))
	print("Detected Face: " + str(detected_face))
	print("PNP error: " + str(pnp_error))
	print("Quaternion: " + str(quaternion))
	print("Euler: " + str(euler))
