extends CharacterBody2D

var state_machine: StateMachine
var dash_speed = 0
var roll_duration = 1
var player_name = "joe"
@export var speed: float = 100
#this is going on your gun next


func _ready() -> void:
	
	state_machine = StateMachine.new()
	state_machine.owner = self
	state_machine.add_state("shoot",ShootState.new())
	state_machine.add_state("idle",IdleState.new())
	state_machine.add_state("walk",WalkState.new())
	state_machine.add_state("jump",JumpState.new())

	state_machine.set_initial_state("idle")


func _process(delta: float) -> void:
	state_machine.update(delta)

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	
func _input(event: InputEvent) -> void:
	state_machine.handle_input(event)
	
func get_current_state()->String:
	return state_machine.get_current_state_name()
