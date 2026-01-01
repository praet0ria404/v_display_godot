class_name OSFStarter


var new_thread: Thread


func start_open_see_face() -> void:
	new_thread = Thread.new()
	new_thread.start(Callable(self, '_thread'))


func _thread() -> void:
	print("start new thread")
	OS.execute('python3', ['open_see_face/OpenSeeFace-master/facetracker.py', '-p 4433', '-v 2'])
