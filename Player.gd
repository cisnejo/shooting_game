extends CharacterBody2D
class_name Player
@onready var AnimimatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var Weapon:Area2D = $weapon
@onready var damage_emitter:Area2D =$DamageEmitter
@onready var damage_emitter_collision:CollisionShape2D = $DamageEmitter/CollisionShape2D
@onready var player_box:CollisionShape2D = $CollisionShape2D
@export var speed: float = 100
@export var PLAYER_BASE_DAMAGE :int =  10
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
var player_box_x_position

var gravity: int = ProjectSettings.get(&"physics/2d/default_gravity")

#this is going on your gun next

func get_weapon()->Area2D:
	return Weapon
	
func _ready() -> void:
	damage_emitter.area_entered.connect(on_emit_damage.bind())
	player_box_x_position = player_box.position.x
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

func on_emit_damage(damage_reciever:DamageReciever)->void:
	var direction := Vector2.LEFT if damage_reciever.global_position.x < global_position.x else Vector2.RIGHT

	damage_reciever.damage_recieved.emit(PLAYER_BASE_DAMAGE, direction)
	
	
func _process(delta: float) -> void:
	state_machine.update(delta)

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	
func _input(event: InputEvent) -> void:
	state_machine.handle_input(event)
	
func get_current_state()->String:
	return state_machine.get_current_state_name()
