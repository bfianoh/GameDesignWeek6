extends Node

@export
var fruit_scene: PackedScene
var points: int

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

# Recieves the sliced signal from the fruits
func _on_fruit_sliced() -> void:
	points += 1

# Receives the timeout signal from the FruitTimer
func _on_fruit_timer_timeout() -> void:
	var spawn_pos = Vector2(randf_range(-400,400), 450)
	var fruit = fruit_scene.instantiate()
	fruit.position = spawn_pos
	fruit.sliced.connect(_on_fruit_sliced)
	add_child(fruit)
