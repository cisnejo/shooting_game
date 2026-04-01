extends Area2D

class_name BulletScript

var state_machine: StateMachine
var bullet_speed = 500
var parent
var targetPosition:Vector2
var shootDirection:Vector2

func with_data(data_) -> CharacterBody2D:
	parent=data_
	return parent
	
func _ready() -> void:
	state_machine = StateMachine.new()
	state_machine.owner = self
	state_machine.add_state("bullet_move",BulletMove.new())
	state_machine.set_initial_state("bullet_move")

func _process(delta: float) -> void:
	state_machine.update(delta)
	
func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	
func _input(event: InputEvent) -> void:
	state_machine.handle_input(event)
	
func get_current_state()->String:
	return state_machine.get_current_state_name()
