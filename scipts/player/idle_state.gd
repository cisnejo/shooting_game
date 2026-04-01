extends StateInterface

class_name IdleState


func enter(previous_state:String="")->void:
	#print("Entering Idle State")
	return
	
func handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up"):
		state_machine.change_state("walk")
	elif Input.is_action_just_pressed("shoot"):
		state_machine.change_state("shoot")
