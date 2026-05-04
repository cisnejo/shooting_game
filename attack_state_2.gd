extends StateInterface

class_name AttackState2

var PLAYER: CharacterBody2D




	
func enter(prev_state: String="")->void:
	PLAYER = state_machine.owner
	state_machine.owner.AnimimatedSprite.play("attack_melee_followup")
	await state_machine.owner.AnimimatedSprite.animation_finished
	state_machine.change_state(state_machine.owner.REVERT_STATE )
	
func physics_update (delta):
	
	return

func handle_input(event):
	
	if Input.is_action_just_pressed("jump") && PLAYER.is_on_floor():
		state_machine.change_state("jump")
		return
