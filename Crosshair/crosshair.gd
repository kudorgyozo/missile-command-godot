extends Node2D

func _draw():
	var crosshair_size = 10
	draw_line(Vector2(-crosshair_size, 0), Vector2(crosshair_size, 0), Color(1, 1, 1), 2)
	draw_line(Vector2(0, -crosshair_size), Vector2(0, crosshair_size), Color(1, 1, 1), 2)
