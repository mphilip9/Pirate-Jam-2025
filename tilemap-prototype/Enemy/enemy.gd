class_name Enemy
extends PathFollow2D

@onready var animation_player: AnimationPlayer = $Sprite/Body/AnimationPlayer
@onready var castle = get_tree().get_first_node_in_group("base")
@export var stats: EnemyStats

var current_health: int:
	set(health_in):
		if health_in < current_health:
			animation_player.play("take_damage")
		current_health = health_in
		if current_health < 1:
			GameData.mort_flesh += 2
			queue_free()


@onready var body: AnimatedSprite2D = $Sprite/Body

var last_fram_pos = Vector2()

func _ready() -> void:
	current_health = stats.max_health
	
	
func _process(delta: float) -> void:
	# progress is the metric the PathFollow3D node uses to track where it is along its parent Path
	progress += delta * stats.speed

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
		castle.take_damage(stats.damage)
		set_process(false)
		queue_free()
		
		
func take_damage(damage) -> void:
	current_health -= damage
	
