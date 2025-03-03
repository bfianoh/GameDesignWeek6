extends Sprite2D

var motion: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate(delta)
	translate(motion * delta)
	if scale.x > 1: apply_scale(Vector2(0.95, 0.95))
	else: self.queue_free()
