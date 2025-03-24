extends Node2D

# Possible Scene tree
# Game
#	Missile (script PlayerMissile -> BaseMissile) 
#	Missile (script EnemyMissile -> BaseMissile)
#	Explosion

@export var missile_scene: PackedScene  # Drag & drop Missile.tscn in the Inspector

func _ready() -> void:
	#preload("res://Explosion.tscn")
	#preload("res://Crosshair.tscn")
	#preload("res://Missile/Missile.tscn")
	#preload("res://Missile/PlayerMissile.gd")
	#preload("res://Missile/EnemyMissile.gd")
	pass
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		spawn_player_missile(event.position)

func spawn_player_missile(target: Vector2):
	var missile = missile_scene.instantiate()
	missile.set_script(load("res://Missile/PlayerMissile.gd"))
	missile.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y)  # Bottom center
	missile.target = target
	add_child(missile)


func _on_timer_timeout() -> void:
	spawn_enemy_missile()

	

func spawn_enemy_missile() -> void:
	var missile = missile_scene.instantiate()
	missile.set_script(load("res://Missile/EnemyMissile.gd"))
	var xStartPos = randf_range(get_viewport_rect().size.x * 0.1, get_viewport_rect().size.x * 0.9)
	var xEndPos = randf_range(get_viewport_rect().size.x * 0.1, get_viewport_rect().size.x * 0.9)
	missile.position = Vector2(xStartPos, 0)  # Bottom center
	missile.target = Vector2(xEndPos, get_viewport_rect().size.y)
	
	add_child(missile)
	
#func spawn_enemy_missile_debug(x_pos: float) -> void:
	#var missile = missile_scene.instantiate()
	##missile.set_script(ResourceLoader.load("res://Missile/EnemyMissile.gd", "", ResourceLoader.CACHE_MODE_IGNORE_DEEP))
	#missile.set_script(load("res://Missile/EnemyMissile.gd"))
	#missile.position = Vector2(x_pos, 0)
	#missile.target = Vector2(x_pos, get_viewport_rect().size.y / 2)
	#add_child(missile)
