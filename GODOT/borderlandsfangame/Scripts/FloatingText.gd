extends Label

@export var float_time : float = 1.0

func _ready() -> void:
	modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, float_time)
	tween.finished.connect(queue_free)
