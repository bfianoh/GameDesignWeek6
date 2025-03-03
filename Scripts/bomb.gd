extends "res://Scripts/launchable.gd"

@export
var particle_scene: PackedScene
var particle_colors: Array = [Color("ffdd00"), Color("eb8600"), Color("eb5700")]

func slice_fx() -> void:
	self.queue_free()

func _on_timer_timeout() -> void:
	if get_parent().particles:
		var particle = particle_scene.instantiate()
		particle.position = $SparkPos.global_position + Vector2(randf_range(-5, 5), randf_range(-5, 5))
		particle.rotation = randf_range(0, 2*PI)
		particle.modulate = particle_colors.pick_random()
		particle.scale = Vector2(20, 20)
		get_parent().add_child(particle)
		pass
