extends Area2D
@export var resource: Weapon
var PLAYER:CharacterBody2D 
#func _ready():
	#var name = resource.weapon_name
	#monitoring = false
	#PLAYER = get_parent()
#
#func _on_body_entered(body: Node2D) -> void:
	#if body.get("resource") != null and body.resource.get("damageable") != null:
		#if body.resource.damageable:
			#body.hit(resource.damage)
			#print(body.name + " was hit for " + str(resource.damage) + " damage by PLAYER ATTACK " + str(PLAYER.CURRENT_ATTACK))
#func check_frame(animation:StringName,frame:int) ->void:
#
	#pass
	#
