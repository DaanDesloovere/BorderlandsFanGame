extends Camera3D

@onready var cam : Camera3D = $"."
var isZoomed : bool = false


func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("Zoom") && !isZoomed):
		cam.fov = 10
		isZoomed = !isZoomed
	elif (event.is_action_pressed("Zoom") && isZoomed):
		cam.fov = 115
		isZoomed = !isZoomed
