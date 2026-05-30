extends Node2D

@onready var player := $ActorsContainer/Player
@onready var camera := $Camera

func _process(delta: float) -> void:
		camera.position.x = player.position.x
		camera.position.y = player.position.y
