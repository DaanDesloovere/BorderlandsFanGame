extends Node3D

var OpenTime = 0.75
var OpenAmount = -160
@onready var IsOpen = false

func Open() -> void:
	if (!IsOpen):
		Constants.GenerateMoney($"../Places")
		var tween := get_tree().create_tween()
		tween.tween_property(
			$"../Safe Door", 
			"rotation_degrees", 
			Vector3(0, OpenAmount, 0), 
			OpenTime
		)
		IsOpen = true
