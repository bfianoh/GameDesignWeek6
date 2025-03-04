extends Sprite2D

var max_scale_factor: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = randf_range(0, 2*PI)
	max_scale_factor = randf_range(0.78, 0.92)
	scale = Vector2(0.1, 0.1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scale.x < max_scale_factor: scale += Vector2(0.07, 0.07)
	modulate.a -= 0.5*delta
