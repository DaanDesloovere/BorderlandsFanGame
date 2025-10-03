extends Area3D

@export var amount : int = 6
@onready var Money : Node3D = $".."

var PickedUp := false
var Player : Node3D


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and not PickedUp:
		PickedUp = true
		Player = body
		await get_tree().create_timer(1.5).timeout 
		# fly towards player
		var tween := create_tween()
		var endPosition = body.global_position - Vector3(0,1,0)
		tween.tween_property(Money, "global_position", endPosition, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.tween_callback(Callable(self, "_finish_pickup"))

func _finish_pickup():
	if Player:
		Player.PickupMoney(amount)
	Money.queue_free()
