extends Node2D
@onready var range_collision_shape = $Range/RangeCollisionShape

#DO NOT NAME tower_stats, it will throw an error
@export var eye_tower_stats: TowerStats
var enemy_path: Path2D

# Called when the node enters the scene tree for the first time.
func _ready():
	range_collision_shape.shape.radius = eye_tower_stats.range


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func find_best_target() -> PathFollow2D:
	#var best_target = null
	#var best_progress: float = 0.0
	#for enemy in enemy_path.get_children():
		#if enemy is PathFollow2D:
			#var distance: float = global_position.distance_to(enemy.global_position)
			#if distance < tower_stats.range and enemy.progress > best_progress:
				#best_target = enemy
				#best_progress = enemy.progress
	#return best_target

func fire(target: CharacterBody2D):
	var projectile = eye_tower_stats.projectile_scene.instantiate()
	print('target here:    ', target)
	projectile.target = target
	add_child(projectile)
func _on_range_body_entered(body):
	#print('body here', body, body.get_parent())
	fire(body)


func _on_range_body_exited(body):
	print('enemy has left the towers range')
