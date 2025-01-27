extends Path2D

@export var difficulty_manager: Node
@onready var timer: Timer = $Timer
@export var enemies_array: Array[PackedScene]
var enemy_spawn_count: int = 0

func spawn_enemy() -> void:
	enemy_spawn_count += 1
	print(enemy_spawn_count)
	var enemy_scene = enemies_array[4]
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	timer.wait_time = difficulty_manager.get_spawn_time()



func _on_difficulty_manager_stop_spawning_enemies() -> void:
	timer.stop() 
	
