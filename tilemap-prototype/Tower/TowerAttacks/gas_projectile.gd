extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D


@export var speed: float = 300.0
@export var damage: int
# The enemy to fire towards
var target
var curr_position: Vector2
signal projectile_hit()

func _ready():
	animated_sprite_2d.play('default')

func _physics_process(delta):
	# disappear at the end of frame progress
	if animated_sprite_2d.frame_progress == 1 :
		queue_free()
		return	
	# set position to the target and stay in that position
	if curr_position == Vector2() :
		curr_position = target.global_position
	global_position = curr_position
	
func _on_hitbox_body_entered(body):
	body.get_parent().take_damage_over_time(100,damage)
