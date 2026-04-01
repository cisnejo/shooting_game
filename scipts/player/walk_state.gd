extends StateInterface

class_name WalkState

var character: CharacterBody2D
@export var speed: float = 100

func enter(prev_state: String="")->void:
	character = state_machine.owner

func physics_update (delta):
	var input_vector = Input.get_vector("move_left","move_right", "move_up","move_down")
	character.velocity = input_vector * speed
	character.move_and_slide()
	if input_vector.x==0 && input_vector.y == 0:
		state_machine.change_state("idle")
		return

	#character.velocity.x = direction * 200
	

func handle_input(event):
	if Input.is_action_just_pressed("shoot"):
		state_machine.change_state("shoot")
		return
	elif Input.is_action_just_pressed("jump"):
		state_machine.change_state("jump")
		return
