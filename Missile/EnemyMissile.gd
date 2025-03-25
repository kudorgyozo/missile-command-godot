class_name EnemyMissile 
extends BaseMissile

func _ready() -> void:
	super._ready()
	speed = Globals.speed_enemy
	explosion_radius = Globals.enemy_radius
	($Area2D as Area2D).monitoring = true
	($Area2D as Area2D).area_entered.connect(explosion_area_entered)
	$GPUParticles2D.lifetime = 6
	$GPUParticles2D.amount = 90
	$Timer.wait_time = 6
	
func explosion_area_entered(_area: Area2D):
	super.call_deferred("explode")
