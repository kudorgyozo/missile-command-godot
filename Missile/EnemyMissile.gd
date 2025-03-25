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
	
func explosion_area_entered(_area: Area2D):
	super.call_deferred("explode")
