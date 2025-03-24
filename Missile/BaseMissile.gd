class_name BaseMissile
extends Node2D

var target: Vector2
var direction: Vector2
var speed: float = 0
var crosshair: Node = null
var disabled: bool = false
var explosion_radius: float = 0
var missile_radius: float = 4

func _ready():
	direction = (target - position).normalized()
	$Timer.wait_time = $GPUParticles2D.lifetime

func _physics_process(delta: float) -> void:
	if disabled : return

	position += direction * speed * delta;
	var distance = position.distance_to(target)
	
	# Move towards the target
	if distance < speed * delta * 0.6:
		position = target  # Snap to target
		explode()

func _draw():
	if disabled: return
	# Draw the missile at the local origin
	draw_circle(Vector2(0, 0), missile_radius, Color(1, 0, 0))  # Red missile dot

func explode():
	# Remove crosshair, disable missile
	if crosshair: crosshair.queue_free()
	disabled = true
	$Timer.start()
	$GPUParticles2D.emitting = false
	queue_redraw()
	($Area2D as Area2D).monitoring = false
	
	# Create explosion 
	#var explosion = load("res://Explosion.tscn").instantiate() as Node2D
	var explosion = ResourceLoader.load("res://Explosion.tscn", "", ResourceLoader.CACHE_MODE_IGNORE_DEEP).instantiate() as Node2D
	
	explosion.position = position
	explosion.max_radius = explosion_radius
	get_parent().add_child(explosion)  # Add explosion to the game scene

func _on_timer_timeout() -> void:
	queue_free()  # Destroy missile when it reaches target
