class_name BaseMissile extends Node2D

@export var resource: MissileResource

@onready var area2d: Area2D = $Area2D
@onready var rayCast2d: RayCast2D = $RayCast2D
@onready var particles: GPUParticles2D = $Particle

var explosion_scene = preload("res://Explosion.tscn")
var crosshair_scene = preload("res://Crosshair/Crosshair.tscn")

## Target position in parent coords
var target_pos: Vector2
## Origin in parent coords
var origin_pos: Vector2
var crosshair: Node = null
var direction: Vector2

func _ready():
	direction = (target_pos - position).normalized()
	particles.lifetime = resource.particleTimeout
	particles.timer.wait_time = resource.particleTimeout

func _draw():
	# Draw the missile at the local origin_pos
	draw_circle(Vector2(0, 0), Globals.missile_radius, Color(1, 0, 0))  # Red missile dot

func explode():
	# Remove crosshair
	if crosshair: crosshair.queue_free()
	
	particles.reparent(get_parent())
	particles.timer.start()
	particles.speed_scale = resource.particle_speedup_on_death
	particles.emitting = false
	
	# Create explosion 
	var explosion = explosion_scene.instantiate() as Node2D
	explosion.position = position
	explosion.max_radius = resource.explosion_radius
	get_parent().add_child(explosion)  # Add explosion to the game scene
	
	queue_free()
