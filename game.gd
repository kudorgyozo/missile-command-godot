extends Node2D

# Possible Scene tree
# Game
#	Missile (script PlayerMissile -> BaseMissile) 
#	Missile (script EnemyMissile -> BaseMissile)
#	Explosion

@export var missile_scene: PackedScene  # Drag & drop Missile.tscn in the Inspector

var playerMissileScript = preload("res://Missile/PlayerMissile.gd")
var enemyMissileScript = preload("res://Missile/EnemyMissile.gd")
var enemyMissileRes = preload("res://Missile/EnemyMissile.tres")
var playerMissileRes = preload("res://Missile/PlayerMissile.tres")

func _ready() -> void:
	preload("res://Missile/Missile.tscn")
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		spawn_player_missile(event.position)

func spawn_player_missile(target: Vector2):

	# var my_lambda = func (prev, curr: Array):
	# 	var dist =  target.distance_to(curr[1].position)
	# 	return curr
	# 	pass

	var launchers = get_tree().get_nodes_in_group("Launchers") as Array[Node2D]
	# launchers.reduce(my_lambda, [90000, launchers[0]])

	var distMax: float = 9_999_999_999
	var origin: Vector2 = Vector2.ZERO

	for launcher in launchers:
		var dist = target.distance_squared_to(launcher.position)
		if dist < distMax:
			distMax = dist
			origin = launcher.launchPoint.global_position
		pass

	var missile = missile_scene.instantiate()
	missile.set_script(playerMissileScript)
	missile.resource = playerMissileRes
	missile.position = origin
	missile.origin_pos = origin
	missile.target_pos = target
	add_child(missile)

func _on_timer_timeout() -> void:
	spawn_enemy_missile()

func spawn_enemy_missile() -> void:
	var missile = missile_scene.instantiate()
	missile.set_script(enemyMissileScript)
	missile.resource = enemyMissileRes
	var xStartPos = randf_range(get_viewport_rect().size.x * 0.1, get_viewport_rect().size.x * 0.9)
	var xEndPos = randf_range(get_viewport_rect().size.x * 0.1, get_viewport_rect().size.x * 0.9)
	missile.position = Vector2(xStartPos, 0)  # Bottom center
	missile.origin_pos = missile.position
	missile.target_pos = Vector2(xEndPos, get_viewport_rect().size.y)
	add_child(missile)
