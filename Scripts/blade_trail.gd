extends Line2D

@export
var trail_length: int
var offset = Vector2(-576, -384) # fixes viewport jank

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_parent().blade:
		add_point(get_viewport().get_mouse_position() + offset)
		if points.size() > trail_length:
			remove_point(0)
