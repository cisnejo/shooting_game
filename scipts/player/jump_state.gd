extends StateInterface

class_name JumpState

var character: CharacterBody2D


func enter(prev_state: String=""):
	character = state_machine.owner
	

func physics_update (delta:float):
	character.roll_duration -= delta
	character.velocity.y += 980 * delta
	character.dash_speed = 600 * character.roll_duration

	var input_vector = Input.get_vector("move_left","move_right", "move_up","move_down")
	character.velocity = input_vector * (1 + character.dash_speed)
	
	character.move_and_slide()
	
	if character.roll_duration <=0 :
		character.roll_duration = 1
		if input_vector.x!=0 || input_vector.y != 0:
			state_machine.change_state("walk")
		else:
			state_machine.change_state("idle")
	
func handle_input(event):
	if Input.is_action_just_pressed("shoot"):
		state_machine.change_state("shoot")
	return
