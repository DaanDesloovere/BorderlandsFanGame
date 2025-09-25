extends Node3D

var OpenTime = 0.75
var OpenAmount = 120
@onready var IsOpen = false
@export var AmmoList : Array

func Open() -> void:
	if (!IsOpen):
		Constants.GenerateAmmo($"../Places")
		var tween := get_tree().create_tween()
		tween.tween_property(
			$"../Ammobox Lid", 
			"rotation_degrees", 
			Vector3(0, 0, OpenAmount), 
			OpenTime
		)
		IsOpen = true
