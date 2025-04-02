extends BaseMissile

func _ready() -> void:
	super._ready()
	speed = Globals.speed_enemy
	explosion_radius = Globals.enemy_radius
	area2d.monitoring = true
	area2d.area_entered.connect(explosion_area_entered)
	gpuParticles.lifetime = 6
	gpuParticles.amount = 90
	timer.wait_time = 6

func _physics_process(delta: float) -> void:
	var delta_pos = direction * speed * delta
	position += delta_pos

func explosion_area_entered(_area: Area2D):
	super.call_deferred("explode")
