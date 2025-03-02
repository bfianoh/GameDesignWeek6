extends "res://Scripts/launchable.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.frame = randi_range(0,9)
	super()

func slice_fx() -> void:
	# TODO: fruit slice effects
	pass
