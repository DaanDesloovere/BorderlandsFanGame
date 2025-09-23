extends Node3D

var OpenTime = 1.25
var OpenAmount = -160


func _ready() -> void:
	pass

func Open() -> void:
	print("lid should open")
	var tween := get_tree().create_tween()
	tween.tween_property(
		$"../Safe Door", 
		"rotation_degrees", 
		Vector3(0, OpenAmount, 0), 
		OpenTime
	)
