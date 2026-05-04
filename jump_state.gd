extends StateInterface

class_name JumpState

var PLAYER: CharacterBody2D

func try_jump() -> void:
	PLAYER.velocity.y = PLAYER.JUMP_VELOCITY
	
func enter(prev_state: String=""):
	PLAYER = state_machine.owner
	try_jump()
	state_machine.owner.AnimimatedSprite.play("jump")
	

func physics_update (delta:float):
	var input_vector:float = Input.get_axis("move_left","move_right")
	PLAYER.velocity.x = input_vector * PLAYER.WALK_SPEED
	PLAYER.velocity.y = minf(PLAYER.TERMINAL_VELOCITY,PLAYER.velocity.y + PLAYER.gravity * delta)
	
	if(PLAYER.velocity.x > 0):
			state_machine.owner.AnimimatedSprite.flip_h = false
	elif (PLAYER.velocity.x <0):
			state_machine.owner.AnimimatedSprite.flip_h = true
			
	PLAYER.move_and_slide()
	#CHANGE STATE --------------------------------
	if PLAYER.velocity.y > 0:
		state_machine.change_state("fall")
		
	

func handle_input(event):

	return
