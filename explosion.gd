extends Node2D

var time_elapsed: float = 0.0
var duration: float = 2.0  # Total explosion duration (2 seconds)
var max_radius: float = 0  # Maximum explosion size
var radius: float = 0

func _process(delta):
	time_elapsed += delta
	
	var progress: float = time_elapsed / duration  # Value from 0 to 1 over 2 seconds
	
	# Expand for the first second, contract for the second
	var scl = 0;
	if progress < 0.5:
		scl = lerpf(0, 1, progress * 2)
	else: 
		scl = lerpf(1, 0, (progress - 0.5) * 2)
	
	scale.x = scl
	scale.y = scl
	
	if radius == 0:
		queue_redraw()
		
	radius = scl * max_radius
	
		
	if time_elapsed >= duration:
		queue_free()  # Remove explosion after animation completes
		return

func _draw():
	if radius == 0: return
	draw_circle(Vector2.ZERO, max_radius, Color(1, 0.5, 0, 0.8))	

	
	  # Orange explosion
