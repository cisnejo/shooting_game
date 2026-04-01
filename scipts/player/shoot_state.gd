extends StateInterface

class_name ShootState

var character: CharacterBody2D

const BULLET = preload("res://bullet.tscn")



func set_object(bullet_instance, position, target_position):
	
	bullet_instance.global_position = position
	var direction = (target_position - position).normalized()
	bullet_instance.rotation_degrees = rad_to_deg(position.angle_to_point(target_position))
	
func enter(prev_state: String="")->void:
	state_machine.change_state(prev_state)
	
	character = state_machine.owner
	var bullet_instance = BULLET.instantiate()
	bullet_instance.with_data(character)
	character.get_tree().root.add_child(bullet_instance)
	bullet_instance.targetPosition = bullet_instance.get_global_mouse_position()
	bullet_instance.shootDirection = (bullet_instance.targetPosition - bullet_instance.global_position).normalized()
	set_object(bullet_instance,bullet_instance.parent.global_position, bullet_instance.targetPosition)
	
	

	
	

func physics_update (delta):
	
	return

	#character.velocity.x = direction * 200
	
