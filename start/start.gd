class_name Start
extends Node2D


signal start_tracking()

@onready var Models: Array[Sprite2D] = [
	$Model0,
	$Model1,
	$Model2,
]


var start_index: int = 0


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left"):
		if start_index > 0:
			start_index -= 1
	elif event.is_action_pressed("move_right"):
		if start_index < len(Models) - 1:
			start_index += 1
	elif event.is_action_pressed("start"):
		_start()

	_display()


func _display() -> void:
	for i in range(len(Models)):
		if i == start_index:
			Models[i].self_modulate = Color8(255, 0, 0)
		else:
			Models[i].self_modulate = Color8(255, 255, 255)


func _start() -> void:
	start_tracking.emit()
	queue_free()


