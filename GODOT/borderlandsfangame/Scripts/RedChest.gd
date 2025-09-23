extends Node3D

var OpenTime = 1.25
var OpenAmount = -120


func _ready() -> void:
	pass

func Open() -> void:
	print("lid should open")
	var tween := get_tree().create_tween()
	tween.tween_property(
		$"../Red Chest Lid", 
		"rotation_degrees", 
		Vector3(OpenAmount, 0, 0), 
		OpenTime
	)
