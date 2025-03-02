extends "res://Scripts/launchable.gd"

var fruit_type: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fruit_type = randi_range(0,9)
	$Sprite2D.frame = fruit_type
	super()

func slice_fx() -> void:
	# TODO: fruit slice effects
	pass
