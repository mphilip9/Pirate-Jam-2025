extends CharacterBody2D


@export var speed: float = 300.0
# The enemy to fire towards
var target: CharacterBody2D


func _physics_process(delta):
	if not target or !is_instance_valid(target):
		queue_free()
		return
	var direction = (target.global_position - global_position).normalized()
	
	velocity = direction * speed
	move_and_slide()


func _on_hitbox_body_entered(body):
	print('hit something:   ', body)
