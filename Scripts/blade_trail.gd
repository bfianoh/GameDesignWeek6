extends Line2D

@export
var trail_length: int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_parent().blade:
		add_point(get_local_mouse_position())
		if points.size() > trail_length:
			remove_point(0)
