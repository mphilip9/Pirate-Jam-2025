extends Node2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var damage: float

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play("explosion")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_explosion_hitbox_body_entered(body):
	print('does this thing work???')
	body.get_parent().take_damage(damage)
	


func _on_animated_sprite_2d_animation_finished():

	get_parent().queue_free()
