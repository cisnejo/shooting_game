extends StateInterface

class_name WalkState

var PLAYER: CharacterBody2D




	
func enter(prev_state: String="")->void:
	PLAYER = state_machine.owner
	
	

func physics_update (delta):
	var input_vector:float = Input.get_axis("move_left","move_right")
	PLAYER.velocity.x = input_vector * PLAYER.WALK_SPEED
	PLAYER.velocity.y = minf(PLAYER.TERMINAL_VELOCITY,PLAYER.velocity.y + PLAYER.gravity * delta)
	PLAYER.move_and_slide()
	
	if PLAYER.velocity.x == 0 && PLAYER.is_on_floor():
		state_machine.change_state("idle")
		state_machine.owner.AnimimatedSprite.play("idle")
		return
	elif  PLAYER.velocity.x != 0 && PLAYER.is_on_floor():
		state_machine.owner.AnimimatedSprite.play("walk")
		if(PLAYER.velocity.x > 0):
			state_machine.owner.AnimimatedSprite.flip_h = false
		elif (PLAYER.velocity.x <0):
			state_machine.owner.AnimimatedSprite.flip_h = true
	#CHANGE STATE --------------------------------

	if PLAYER.velocity.y > 0:
		state_machine.change_state("fall")

	#character.velocity.x = direction * 200
	

func handle_input(event):
	
	if Input.is_action_just_pressed("jump") && PLAYER.is_on_floor():
		state_machine.change_state("jump")
	elif  Input.is_action_just_pressed("attack") && PLAYER.is_on_floor():
		state_machine.change_state("attack")
