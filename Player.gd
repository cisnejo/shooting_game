extends CharacterBody2D

@onready var AnimimatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var Weapon:Area2D = $weapon
@export var speed: float = 100

var state_machine: StateMachine
const WALK_SPEED = 300.0
const ACCELERATION_SPEED = WALK_SPEED * 6.0
const JUMP_VELOCITY = -250.0
## Maximum speed at which the player can fall.
const TERMINAL_VELOCITY = 700
var REVERT_STATE =""
var MAX_ALLOWABLE_ATTACK = 2
var CURRENT_ATTACK = 1
var player_name = "joe"

var gravity: int = ProjectSettings.get(&"physics/2d/default_gravity")

#this is going on your gun next

func get_weapon()->Area2D:
	return Weapon
	
func _ready() -> void:
	
	state_machine = StateMachine.new()
	state_machine.owner = self
	state_machine.add_state("shoot",ShootState.new())
	state_machine.add_state("idle",IdleState.new())
	state_machine.add_state("walk",WalkState.new())
	state_machine.add_state("dash",DashState.new())
	state_machine.add_state("jump",JumpState.new())
	state_machine.add_state("fall",FallState.new())
	state_machine.add_state("attack",AttackState.new())
	
	state_machine.set_initial_state("idle")


func _process(delta: float) -> void:
	state_machine.update(delta)

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	
func _input(event: InputEvent) -> void:
	state_machine.handle_input(event)
	
func get_current_state()->String:
	return state_machine.get_current_state_name()
