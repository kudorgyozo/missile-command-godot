extends Node2D

@export var crosshair_scene: PackedScene  # Assign Crosshair.tscn in Inspector
@export var explosion_scene: PackedScene  # Assign Explosion.tscn in the Inspector

var target: Vector2 = Vector2(1,23)
var speed: float = 0
var crosshair: Node = null
var disabled: bool = false
var enemy: bool = false

func _ready():
	print("missile ready")
	# Create and attach the crosshair
	if !self.enemy:
		crosshair = crosshair_scene.instantiate()
		crosshair.position = target  # Place it at the target location
		get_parent().add_child(crosshair)  # Add it to the game (not the missile)
		speed = Globals.speed
	else:
		speed = Globals.speed_enemy
	
	$Timer.wait_time = $GPUParticles2D.lifetime

func _process(delta):
	if disabled : return
	
	var direction = (target - position).normalized()
	var distance = position.distance_to(target)
	# Move towards the target
	if distance > speed * delta:
		position += direction * speed * delta
		#queue_redraw()
	else:
		explode()
		#position = target  # Snap to target

func _draw():
	if disabled: return
	# Draw the missile at the local origin
	draw_circle(Vector2(0, 0), 3, Color(1, 0, 0))  # Red missile dot

func explode():
	# Remove crosshair, disable missile
	if !enemy: crosshair.queue_free()
	disabled = true
	$Timer.start()
	$GPUParticles2D.emitting = false
	queue_redraw()
	
	# Create explosion at target position
	var explosion = explosion_scene.instantiate()
	explosion.position = target
	explosion.max_radius = Globals.enemy_radius if enemy else Globals.player_radius
	get_parent().add_child(explosion)  # Add explosion to the game scene

func set_enemy(_enemy: bool) -> void:
	enemy = _enemy
	if enemy: 
		speed = 100
	
func _on_timer_timeout() -> void:
	queue_free()  # Destroy missile when it reaches target
