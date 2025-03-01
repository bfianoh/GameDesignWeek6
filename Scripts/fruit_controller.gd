extends RigidBody2D

@export
var launch_force = 2000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_pickable = true
	$Sprite2D.set_frame(randi() % 10)
	
	var launch_dir = randf_range(-0.25, 0.25)
	var launch_vector = Vector2(launch_dir, -1)
	var offset = Vector2(randf()/150, 0) * -sign(launch_dir)
	self.apply_impulse(launch_vector*launch_force*randf_range(0.9, 1.1), offset)

func _on_mouse_entered() -> void:
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	# TODO: detect mouse speed, cut effects, add points
