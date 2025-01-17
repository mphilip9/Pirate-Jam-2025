extends Path2D

@onready var path_follow = $PathFollow2D
@onready var ene_animation = $PathFollow2D/EnemySpirte/body
@onready var ene_clo_animation = $PathFollow2D/EnemySpirte/body/clothes
@onready var ene_hair_animation = $PathFollow2D/EnemySpirte/body/hair
@onready var ene_hat_animation = $PathFollow2D/EnemySpirte/body/hat
var ene_speed = 100
var last_fram_pos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	path_follow.progress += ene_speed * delta
	print(last_fram_pos, path_follow.position, last_fram_pos - path_follow.position)
	var diff_vector = path_follow.position - last_fram_pos
	if diff_vector.x != 0 :
		ene_animation.play("right")
		ene_clo_animation.play("right")
		ene_hair_animation.play("right")
		ene_hat_animation.play("right")
	elif diff_vector.y != 0 :
		if diff_vector.y > 0 :
			ene_animation.play("bot")
			ene_clo_animation.play("bot")
			ene_hair_animation.play("bot")
			ene_hat_animation.play("bot")
		elif diff_vector.y < 0 :
			ene_animation.play("top")
			ene_clo_animation.play("top")
			ene_hair_animation.play("top")
			ene_hat_animation.play("top")
	last_fram_pos = path_follow.position
