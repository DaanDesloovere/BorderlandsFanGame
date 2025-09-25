extends Node3D

var OpenTime = 0.75
var OpenAmount = -120
@onready var IsOpen = false

func Open() -> void:
	if (!IsOpen):
		var tween := get_tree().create_tween()
		tween.tween_property(
			$"../Red Chest Lid", 
			"rotation_degrees", 
			Vector3(OpenAmount, 0, 0), 
			OpenTime
		)
		IsOpen = true
