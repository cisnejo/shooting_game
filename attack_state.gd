extends StateInterface

class_name AttackState

var PLAYER: Player
var ANIMATED_SPRITE: AnimatedSprite2D
var CURRENT_ATTACK_FRAME = 0
var CURRENT_ATTACK_NAME:String
var WEAPON
var PREV_STATE: String = ""
var attackbox_is_active 
var PLAYER_ATTACK_RESET = false
var PLAYER_DAMAGE_EMITER:Area2D
var PREV_ATTACK_FRAME:int = -1

func enter(prev_state: String="")->void:
	#Inital values on state enter
	PREV_ATTACK_FRAME = 0
	PREV_STATE = prev_state
	PLAYER = state_machine.owner
	PLAYER_DAMAGE_EMITER = PLAYER.damage_emitter
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
	var current_animation_frame = ANIMATED_SPRITE.get_frame()
	if PLAYER.CURRENT_ATTACK <= PLAYER.MAX_ALLOWABLE_ATTACK :
	
		attackbox_is_active = ANIMATED_SPRITE.resource.is_active(CURRENT_ATTACK_NAME,current_animation_frame)
		
		if attackbox_is_active && current_animation_frame != PREV_ATTACK_FRAME:
			
			PLAYER_DAMAGE_EMITER.monitoring = true
			PLAYER.damage_emitter_collision.disabled = false
			PREV_ATTACK_FRAME =current_animation_frame 
		else:
			PLAYER_DAMAGE_EMITER.monitoring = false
			PLAYER.damage_emitter_collision.disabled = true
			
		#if animation finished, return to previous state
	if ANIMATED_SPRITE.frame_progress == 1 :
		PLAYER_ATTACK_RESET = true
		state_machine.change_state(PLAYER.REVERT_STATE)
	
	#if the frame is between the start and finish of the attack, then allow monitoring of the weapon
	return

func handle_input(event):
	
	if Input.is_action_just_pressed("jump") && PLAYER.is_on_floor():
		state_machine.change_state("jump")
		
	elif  Input.is_action_just_pressed("attack") && PLAYER.CURRENT_ATTACK < PLAYER.MAX_ALLOWABLE_ATTACK:
		state_machine.change_state("attack")

func exit()->void:
	if PLAYER_DAMAGE_EMITER:
		PLAYER_DAMAGE_EMITER.monitoring = false
		PLAYER.damage_emitter_collision.disabled = true
		if PLAYER_ATTACK_RESET == true:
			PLAYER.CURRENT_ATTACK = 1
			PLAYER_ATTACK_RESET = false
		else:
			PLAYER.CURRENT_ATTACK += 1
	pass
		
