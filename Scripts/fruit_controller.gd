extends RigidBody2D

signal sliced
signal missed

@export
var launch_force: float
var mouse_speed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_pickable = true
	$Sprite2D.set_frame(randi() % 10)
	
	var launch_dir = randf_range(-0.25, 0.25)
	var launch_vector = Vector2(launch_dir, -1)
	var offset = Vector2(randf()/150, 0) * -sign(launch_dir)
	self.apply_impulse(launch_vector*launch_force*randf_range(0.9, 1.1), offset)

# Called every frame
func _process(delta) -> void:
	mouse_speed = 0
	if position.y > 460:
		missed.emit()
		self.queue_free()

# Called whenever any event fires
func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		mouse_speed = event.velocity.length_squared()

# Recieves the mouse_entered signal from the RigidBody2D
func _on_mouse_entered() -> void:
	if mouse_speed > 1000:
		sliced.emit()
		# TODO: slice effects
		self.queue_free()
