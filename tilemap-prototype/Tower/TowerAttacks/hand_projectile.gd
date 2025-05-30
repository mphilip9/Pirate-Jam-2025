extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D


@export var speed: float = 300.0
@export var damage: int
# The enemy to fire towards
var target
var curr_position: Vector2
var first_target_hit: bool = false
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
	if first_target_hit == false :
		body.get_parent().take_damage(damage)
		body.get_parent().crowd_control_slow(200, 1)
		# comment line 31 out if you wanna see how it is when the projectile is AoE
		first_target_hit = true
	else :
		return
	
