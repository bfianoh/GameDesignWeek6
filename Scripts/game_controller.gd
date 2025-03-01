extends Node

@export
var fruit_scene: PackedScene
@export
var bomb_scene: PackedScene
var lives: int = 3
var points: int = 0
var wave_sizes: Array = [1, 1, 2, 2, 2, 3, 3, 3, 4]

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

# Ends the game when you run out of lives
func game_over() -> void:
	$FruitTimer.stop()
	$DeathLabel.set_visible(true)

# Sets the lives value and the ingame display
func set_lives(val) -> void:
	lives = val
	$LivesLabel.text = "❤️".repeat(max(val, 0))

# Recieves the sliced signal from the fruits
func _on_fruit_sliced() -> void:
	points += 1
	$ScoreLabel.text = "%03d" % points

# Recieves the missed signal from the fruits
func _on_fruit_missed() -> void:
	set_lives(lives - 1)
	if lives == 0: game_over()

# Recieves the sliced signal from the bombs
func _on_bomb_sliced() -> void:
	set_lives(0)
	game_over()

# Receives the timeout signal from the FruitTimer
func _on_fruit_timer_timeout() -> void:
	for i in wave_sizes.pick_random():
		var spawn_pos = Vector2(randf_range(-420,420), 450)
		if randf() < 0.2:
			var bomb = bomb_scene.instantiate()
			bomb.position = spawn_pos
			bomb.sliced.connect(_on_bomb_sliced)
			add_child(bomb)
		else:
			var fruit = fruit_scene.instantiate()
			fruit.position = spawn_pos
			fruit.sliced.connect(_on_fruit_sliced)
			fruit.missed.connect(_on_fruit_missed)
			add_child(fruit)
