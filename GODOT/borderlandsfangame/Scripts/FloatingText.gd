extends ColorRect

@export var float_time : float = 1.0

func _ready() -> void:
	var endPosition = self.global_position - Vector2(280,0)
	var tween = create_tween()
	tween.tween_property(self, "global_position", endPosition, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate:a", 1.0, float_time*3)
	tween.tween_property(self, "modulate:a", 0.0, float_time)
	await tween.finished
	queue_free()
