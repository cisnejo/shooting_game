extends StateInterface

class_name BulletMove
var bullet:Area2D
var speed = 100
var amplitude = 100.0
var time = 0


	
func enter(previous_state:String="")->void:


	

	return

	

	

func physics_update (delta):
	time += delta
	bullet = state_machine.owner
	bullet.position += bullet.transform.x * speed * delta 
	#bullet.position.y += sin(PI * time) * delta * 500
