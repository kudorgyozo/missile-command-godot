class_name PlayerMissile 
extends BaseMissile

func _ready():
	super._ready()
	speed = Globals.speed
	explosion_radius = Globals.player_radius

	# player missile spawns crosshair also
	crosshair = load("res://Crosshair.tscn").instantiate()
	crosshair.position = target  # Place it at the target location
	get_parent().add_child(crosshair)  # Add it to the game (not the missile)
