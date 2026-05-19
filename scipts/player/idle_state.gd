extends StateInterface

class_name IdleState
var PLAYER:CharacterBody2D

func enter(previous_state:String="")->void:
	PLAYER = state_machine.owner
	state_machine.owner.AnimimatedSprite.play("idle")
	var sword_scene = load("res://scenes/weapon.tscn")
	var sword_instance = sword_scene.instantiate()
	PLAYER.add_child(sword_instance)
		
	return
	
func handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") and PLAYER.is_on_floor():
		state_machine.change_state("walk")
	elif  Input.is_action_just_pressed("jump") && PLAYER.is_on_floor():
		state_machine.change_state("jump")
	elif  Input.is_action_just_pressed("attack") && PLAYER.is_on_floor():
		state_machine.change_state("attack")
	#elif Input.is_action_just_pressed("shoot"):
		#state_machine.change_state("shoot")
func physics_update (delta: float) -> void:

	PLAYER.velocity.y = minf(PLAYER.TERMINAL_VELOCITY,PLAYER.velocity.y + PLAYER.gravity * delta)
	PLAYER.move_and_slide()

	return
