extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D


@export var speed: float 
@export var damage: int
# The enemy to fire towards
var target
var og_direction

signal projectile_hit()

func _ready():
	var direction = target.global_position - global_position
	var angle = atan2(direction.y,direction.x)
	og_direction = direction.normalized()
	rotation = angle
	animated_sprite_2d.play('default')

func _physics_process(delta):
	#if not target or !is_instance_valid(target):
		#queue_free()
		#return
	print(og_direction)
	velocity = og_direction * speed
	move_and_slide()


func _on_hitbox_body_entered(body):
#	The parent Node has the take_damage function, not the body itself
# We could add a check to see if the body is in the enemy group
	body.get_parent().take_damage(damage)
	body.get_parent().push_backwards(20)
	#queue_free()


func _on_timer_timeout():
	queue_free()
