extends Path2D

@export var enemy_scene: PackedScene
@export var difficulty_manager: Node
@onready var timer: Timer = $Timer

func spawn_enemy() -> void:
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	timer.wait_time = difficulty_manager.get_spawn_time()



func _on_difficulty_manager_stop_spawning_enemies() -> void:
	print('hit end of enemy spawning')
	timer.stop() 
	
