class_name Enemy
extends PathFollow2D

@export var speed: float = 500.0
@export var max_health : int = 100
@export var gold_value := 15
@onready var animation_player: AnimationPlayer = $Sprite/Body/AnimationPlayer

var current_health: int:
	set(health_in):
		if health_in < current_health:
			animation_player.play("take_damage")
		current_health = health_in
		if current_health < 1:
			print('died')
			queue_free()


@onready var body: AnimatedSprite2D = $Sprite/Body

var last_fram_pos = Vector2()

func _ready() -> void:
	current_health = max_health
	
func _process(delta: float) -> void:
	var castle = get_node("../../Castle")
	# progress is the metric the PathFollow3D node uses to track where it is along its parent Path
	progress += delta * speed

	# current_health -= 1
	var diff_vector = position - last_fram_pos
	if diff_vector.x != 0 :
		body.play("right")
	
	elif diff_vector.y != 0 :
		if diff_vector.y > 0 :
			body.play("down")
		
		elif diff_vector.y < 0 :
			body.play("up")

	last_fram_pos = position
	if progress_ratio == 1.0:
		print('reached the end')
		castle.take_damage()
		set_process(false)
		queue_free()
		
		
func take_damage(damage) -> void:
	current_health -= damage
