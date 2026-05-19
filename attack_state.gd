extends StateInterface

class_name AttackState

var PLAYER: CharacterBody2D
var ANIMATED_SPRITE: AnimatedSprite2D
var CURRENT_ATTACK_FRAME = 0
var CURRENT_ATTACK_NAME:String
var WEAPON
var PREV_STATE: String = ""
var attackbox_is_active 
var PLAYER_ATTACK_RESET = false

func enter(prev_state: String="")->void:
	#Inital values on state enter
	
	PREV_STATE = prev_state
	PLAYER = state_machine.owner
	ANIMATED_SPRITE = PLAYER.AnimimatedSprite
	WEAPON = PLAYER.get_weapon()
	CURRENT_ATTACK_NAME = "".join(["attack_",str(PLAYER.CURRENT_ATTACK)])
	
	#Enforce maximum attacks
	if PLAYER.CURRENT_ATTACK <= PLAYER.MAX_ALLOWABLE_ATTACK :
		ANIMATED_SPRITE.stop()
		ANIMATED_SPRITE.play(CURRENT_ATTACK_NAME)
		if not "attack"  in PREV_STATE :
			PLAYER.REVERT_STATE = PREV_STATE
		else:
			#previous state is an attack state
			pass
	else:
		
		
		pass
		
	
	
	
	
	#MAKE IT SO MONIORING DOES NOT FLICKER DURING AN ACTIVE ATTACK
	
	
func physics_update (delta):
	
	if PLAYER.CURRENT_ATTACK <= PLAYER.MAX_ALLOWABLE_ATTACK :

		var current_animation_frame = ANIMATED_SPRITE.get_frame()
		
		attackbox_is_active = ANIMATED_SPRITE.resource.is_active(CURRENT_ATTACK_NAME,current_animation_frame)
		if attackbox_is_active:
			WEAPON.monitoring = true
		else:
			WEAPON.monitoring = false
		#if animation finished, return to previous state
	if ANIMATED_SPRITE.frame_progress == 1 :
		PLAYER_ATTACK_RESET = true
		state_machine.change_state(PLAYER.REVERT_STATE)
	
	#if the frame is between the start and finish of the attack, then allow monitoring of the weapon
	return

func handle_input(event):
	
	if Input.is_action_just_pressed("jump") && PLAYER.is_on_floor():
		state_machine.change_state("jump")
		
	elif  Input.is_action_just_pressed("attack") && PLAYER.is_on_floor() && PLAYER.CURRENT_ATTACK < PLAYER.MAX_ALLOWABLE_ATTACK:
		state_machine.change_state("attack")

func exit()->void:
	if WEAPON:
		WEAPON.monitoring = false
		if PLAYER_ATTACK_RESET == true:
			PLAYER.CURRENT_ATTACK = 1
			PLAYER_ATTACK_RESET = false
		else:
			PLAYER.CURRENT_ATTACK += 1
		
