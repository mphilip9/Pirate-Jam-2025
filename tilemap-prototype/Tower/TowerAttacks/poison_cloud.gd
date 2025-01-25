extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D

@export var speed: float = 100.0
@export var damage: int
@export var max_distance: float = 50
@onready var timer = $Timer


signal projectile_hit()

var start_position: Vector2
var distance_traveled: float = 0.0


func _ready():
	animated_sprite_2d.play('default')
	start_position = global_position
	timer.start()



func _physics_process(delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		move_and_slide()
		distance_traveled = start_position.distance_to(global_position)
		
		if distance_traveled >= max_distance:
			velocity = Vector2.ZERO


func _on_hitbox_body_entered(body):
#	The parent Node has the take_damage function, not the body itself
# We could add a check to see if the body is in the enemy group
	body.get_parent().take_damage(damage)
#	TODO: queue_free() need to delete after it leaves map bounds


func _on_timer_timeout():
	queue_free()
