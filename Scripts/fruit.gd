extends "res://Scripts/launchable.gd"

@export
var slice_scene: PackedScene
@export
var splat_scene: PackedScene
@export 
var particle_scene: PackedScene
var particle_colors: Array = [
	Color("fff2a1"), Color("fff2a1"), Color("ff8500"), Color("99e442"), Color("ffe538"), 
	Color("c5d43d"), Color("dfe0e8"), Color("dfe0e8"), Color("bfcc47"), Color("ff5277")
]
var fruit_type: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fruit_type = randi_range(0,9)
	$Sprite2D.frame = fruit_type
	super()

# Called when this fruit is sliced
func slice_fx() -> void:
	# Spawn fruit slices
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
	# Spawn splat effect
	if get_parent().splats:
		var splat = splat_scene.instantiate()
		splat.position = position
		splat.modulate = particle_colors[fruit_type]
		get_parent().add_child(splat)
	# Spawn juice particles
	if get_parent().particles:
		for i in 20:
			var particle = particle_scene.instantiate()
			var direction = Vector2(randf_range(-30, 30), randf_range(-30, 30))
			particle.position = position + direction
			particle.motion = direction*8
			particle.rotation = randf_range(0, 2*PI)
			particle.modulate = particle_colors[fruit_type]
			var size = randf_range(24, 30)
			particle.scale = Vector2(size, size)
			get_parent().add_child(particle)
	# Remove the fruit object
	self.queue_free()
