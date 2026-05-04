extends CharacterBody2D
@export var resource: Weapon

func _ready():
	var name = resource.weapon_name
	print(name)
