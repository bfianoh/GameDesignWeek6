extends "res://Scripts/launchable.gd"

@export
var slice_scene: PackedScene
var fruit_type: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fruit_type = randi_range(0,9)
	$Sprite2D.frame = fruit_type
	super()

func slice_fx() -> void:
	if get_parent().slices:
		var eject_vector = Vector2(randf_range(100, 300), randf_range(100, 300))
		for i in 2:
			var slice = slice_scene.instantiate()
			slice.linear_velocity = linear_velocity
			if linear_velocity.y > 100: slice.linear_velocity.y /= 5
			slice.angular_velocity = angular_velocity
			slice.position = position
			slice.get_child(0).frame = 10 + fruit_type
			slice.look_at(position + eject_vector.normalized())
			slice.apply_impulse(eject_vector)
			get_parent().add_child(slice)
			eject_vector *= -1
	
	if get_parent().splats:
		pass
