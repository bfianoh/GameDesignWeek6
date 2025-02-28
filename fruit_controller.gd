extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_pickable = true
	var launch_dir = (randf()-0.5)*800
	var launch_vector = Vector2(launch_dir, -2000)
	var offset = Vector2(randf()/150, 0) * -sign(launch_dir)
	self.apply_impulse(launch_vector, offset)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_mouse_entered() -> void:
	print("fruit hit")
	# TODO: slice the fruit!
