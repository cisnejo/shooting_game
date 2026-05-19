extends CharacterBody2D
@export var resource: Enemy

func hit(damage:int):
	resource.health-=damage
	if(resource.health<= 0):
		self.queue_free()
