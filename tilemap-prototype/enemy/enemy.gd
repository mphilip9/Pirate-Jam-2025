class_name Enemy
extends PathFollow2D

@export var speed: float = 100.0
@export var max_health : int = 50
@export var gold_value := 15

var current_health: int:
	set(health_in):
		if health_in < current_health:
			current_health = health_in
		if current_health < 1:
			queue_free()


@onready var body: AnimatedSprite2D = $Sprite/Body

var last_fram_pos = Vector2()


func _process(delta: float) -> void:
	# progress is the metric the PathFollow3D node uses to track where it is along its parent Path
	progress += delta * speed
	
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
		set_process(false)
		queue_free()
