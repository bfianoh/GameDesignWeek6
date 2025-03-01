extends Node

@export
var fruit_scene: PackedScene

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_fruit_timer_timeout() -> void:
	var spawn_pos = Vector2(randf_range(-400,400), 450)
	var fruit = fruit_scene.instantiate()
	fruit.position = spawn_pos
	add_child(fruit)
