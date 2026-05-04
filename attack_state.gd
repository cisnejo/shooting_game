extends StateInterface

class_name AttackState

var PLAYER: CharacterBody2D




	
func enter(prev_state: String="")->void:
	PLAYER = state_machine.owner
	state_machine.owner.AnimimatedSprite.play("attack_melee_default")
	await state_machine.owner.AnimimatedSprite.animation_finished
	state_machine.owner.REVERT_STATE = prev_state
	state_machine.change_state(prev_state)
	
	
func physics_update (delta):
	
	return

func handle_input(event):
	
	if Input.is_action_just_pressed("jump") && PLAYER.is_on_floor():
		state_machine.change_state("jump")
	elif  Input.is_action_just_pressed("attack") && PLAYER.is_on_floor():
		
		state_machine.change_state("attack2")
