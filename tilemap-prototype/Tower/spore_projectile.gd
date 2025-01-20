extends CharacterBody2D


@export var speed: float = 300.0
@export var damage: int
# The enemy to fire towards
var target

signal projectile_hit()

func _physics_process(delta):
	if not target or !is_instance_valid(target):
		queue_free()
		return
	var direction = (target.global_position - global_position).normalized()
	
	velocity = direction * speed
	move_and_slide()


func _on_hitbox_body_entered(body):
#	The parent Node has the take_damage function, not the body itself
# We could add a check to see if the body is in the enemy group
	body.get_parent().take_damage(damage)
	queue_free()
