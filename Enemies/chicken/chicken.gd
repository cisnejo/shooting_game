extends CharacterBody2D
@export var resource: Enemy
@export var knockback_intensity:float

@onready var damage_reciever:DamageReciever=$DamageReciever
@onready var sprite:AnimatedSprite2D = $Sprite2D
var timeout_default:float = 10
var timer 
var oscillate_damage_timer = false
var current_velocity := Vector2.ZERO
var height_speed:= 2
var height = 0
var gravity: int = ProjectSettings.get(&"physics/2d/default_gravity")

func _ready() -> void:
	damage_reciever.damage_recieved.connect(on_recieved_damage.bind())
	timer = timeout_default
	
func on_recieved_damage(damage:int, direction: Vector2)->void:
	current_velocity = direction * knockback_intensity
	resource.health-=damage
	oscillate_damage_timer = true
	if(resource.health<= 0):
		queue_free()
		
func _process(delta: float) -> void:
	
	if oscillate_damage_timer:
		
		timer -=  delta*7
		if timer > 0:
			print(current_velocity)
			velocity = current_velocity 
			sprite.position = Vector2.UP * height
			current_velocity *= Vector2(1/delta*.01,0) 
			#
			oscillate_damage_indicator(timer)
			move_and_slide()
		else:
			oscillate_damage_timer = false
			timer = timeout_default
	pass
func haldle_air_time (delta:float)->void:
	height += height_speed * delta
	if height < 0:
		height = 0
		queue_free()
	else:
		height_speed -= gravity  * delta
func oscillate_damage_indicator(current_time_elapsed:int)->void:

	if current_time_elapsed % 2 == 0:
		sprite.modulate = Color(1,1,1)
	else:
		sprite.modulate = Color(1,0,0)
	pass
#func hit(damage:int):
	#resource.health-=damage
	#if(resource.health<= 0):
		#self.queue_free()
