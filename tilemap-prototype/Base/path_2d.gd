extends Path2D

@onready var path_follow = $PathFollow2D
@onready var ene_animation = $PathFollow2D/EnemySpirte/body
var ene_speed = 100
var last_fram_pos = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress += ene_speed * delta
	var diff_vector = path_follow.position - last_fram_pos
	if diff_vector.x != 0 :
		ene_animation.play("right")
	
	elif diff_vector.y != 0 :
		if diff_vector.y > 0 :
			ene_animation.play("right")
		
		elif diff_vector.y < 0 :
			ene_animation.play("right")

	last_fram_pos = path_follow.position
