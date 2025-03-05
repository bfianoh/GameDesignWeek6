extends Node

@export
var fruit_scene: PackedScene
@export
var bomb_scene: PackedScene

var lives: int = 3
var points: int = 0
var wave_sizes: Array = [1, 1, 2, 2, 2, 3, 3, 3, 4]

var slices: bool = false
var splats: bool = false
var particles: bool = false
var sounds: bool = false
var blade: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var explosion = $Explosion
	if explosion.modulate.a > 0: explosion.modulate.a -= delta * 0.7

# Ends the game when you run out of lives
func game_over() -> void:
	$FruitTimer.stop()
	$DeathText.set_visible(true)

# Sets the lives value and the ingame display
func set_lives(val) -> void:
	lives = val
	$LivesDisplay.text = "❤️".repeat(max(val, 0))

# Called whenever any event fires
func _unhandled_input(event) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_R:
			get_tree().reload_current_scene()
		if event.keycode == KEY_1:
			var toggle = $ToggleBar/SliceToggle
			toggle.button_pressed = !toggle.button_pressed
		if event.keycode == KEY_2:
			var toggle = $ToggleBar/ParticleToggle
			toggle.button_pressed = !toggle.button_pressed
		if event.keycode == KEY_3:
			var toggle = $ToggleBar/SplatToggle
			toggle.button_pressed = !toggle.button_pressed
		if event.keycode == KEY_4:
			var toggle = $ToggleBar/SoundToggle
			toggle.button_pressed = !toggle.button_pressed
		if event.keycode == KEY_5:
			var toggle = $ToggleBar/BladeToggle
			toggle.button_pressed = !toggle.button_pressed

# Recieves the sliced signal from the fruits
func _on_fruit_sliced() -> void:
	if sounds: $CutSound.play()
	points += 1
	$ScoreDisplay.text = "%03d" % points

# Recieves the missed signal from the fruits
func _on_fruit_missed() -> void:
	if sounds: $DropSound.play()
	set_lives(lives - 1)
	if lives == 0: game_over()

# Recieves the sliced signal from the bombs
func _on_bomb_sliced() -> void:
	if sounds: $BombSound.play()
	$Explosion.modulate.a = 1
	get_tree().call_group("Fruits","slice_fx")
	set_lives(0)
	game_over()

# Receives the timeout signal from the FruitTimer
func _on_fruit_timer_timeout() -> void:
	var wave_size = wave_sizes.pick_random()
	if points < 5 and wave_size > 1: wave_size -= 1
	for i in wave_size:
		var spawn_pos = Vector2(randf_range(-420,420), 450)
		if randf() < 0.15:
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
		if sounds: $LaunchSound.play()
		await get_tree().create_timer(randf_range(0.09, 0.11)).timeout

# Recievers for the toggle buttons
func _on_slice_toggle_toggled(toggled_on: bool) -> void:
	slices = toggled_on
func _on_particle_toggle_toggled(toggled_on: bool) -> void:
	particles = toggled_on
func _on_splat_toggle_toggled(toggled_on: bool) -> void:
	splats = toggled_on
func _on_sound_toggle_toggled(toggled_on: bool) -> void:
	sounds = toggled_on
func _on_blade_toggle_toggled(toggled_on: bool) -> void:
	blade = toggled_on
