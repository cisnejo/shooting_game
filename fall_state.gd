extends StateInterface

class_name FallState

var PLAYER: CharacterBody2D

	
func enter(prev_state: String=""):
	PLAYER = state_machine.owner
	state_machine.owner.AnimimatedSprite.play("fall")
	

func physics_update (delta:float):

	var input_vector:float = Input.get_axis("move_left","move_right")
	PLAYER.velocity.x = input_vector * PLAYER.WALK_SPEED
	PLAYER.velocity.y = minf(PLAYER.TERMINAL_VELOCITY,PLAYER.velocity.y + PLAYER.gravity * delta)
	PLAYER.move_and_slide()
	
	if(PLAYER.velocity.x > 0):
			state_machine.owner.AnimimatedSprite.flip_h = false
	elif (PLAYER.velocity.x <0):
			state_machine.owner.AnimimatedSprite.flip_h = true
	#CHANGE STATE --------------------------------
	if PLAYER.is_on_floor():
		state_machine.change_state("walk")
	

func handle_input(event):

	return
