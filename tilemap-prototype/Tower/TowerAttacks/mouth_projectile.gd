extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D

@export var explosion_scene: PackedScene
@export var speed: float 
@export var damage: int
# The enemy to fire towards
var target

signal projectile_hit()

func _ready():
	animated_sprite_2d.play('default')

func _physics_process(delta):
	if not target or !is_instance_valid(target):
		return
	var direction = (target.global_position - global_position).normalized()
	
	velocity = direction * speed
	move_and_slide()



func _on_hitbox_body_entered(body):
	speed = 0
	animated_sprite_2d.stop()
	animated_sprite_2d.visible = false
	var explosion = explosion_scene.instantiate()
	explosion.damage = damage
	add_child(explosion)
