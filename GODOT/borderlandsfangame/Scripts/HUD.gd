extends CanvasLayer

@onready var floating_numbers = $FloatingNumbers

func SpawnMoneyUpdate(amount: int, world_pos: Vector3, camera: Camera3D) -> void:
	var floating_scene = preload("res://Assets/UI/FloatingText.tscn")
	var text = floating_scene.instantiate()
	text.text = "+$%d" % amount
	# project world position to screen
	floating_numbers.add_child(text)
