extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D

@export var speed: float = 300.0
@export var damage: int

signal projectile_hit()

func _ready():
	animated_sprite_2d.play('default')



func _physics_process(delta):
	velocity = velocity.normalized() * speed
	move_and_slide()


func _on_hitbox_body_entered(body):
#	The parent Node has the take_damage function, not the body itself
# We could add a check to see if the body is in the enemy group
	body.get_parent().take_damage(damage)
#	TODO: queue_free() need to delete after it leaves map bounds


func _on_timer_timeout():
	queue_free()
