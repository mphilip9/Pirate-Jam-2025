extends Path2D

@export var difficulty_manager: Node
@onready var timer: Timer = $EnemySpawnTimer
@export var enemies_array: Array[PackedScene]
var enemy_spawn_count: int = 0
	
func spawn_enemy() -> void:
	enemy_spawn_count += 1
	print('enemy count : ',enemy_spawn_count, ' wave : ', GameData.wave)
	var enemy_ind: int = 0
	# TODO: need a better way to manage what spawn. feels like there is an easiser way
	# wave 2 count 40
	if GameData.wave == 2 :
		if enemy_spawn_count > 15 and enemy_spawn_count < 30 :
			enemy_ind = 1
	# wave 3 count 40
	if GameData.wave == 3 :
		if enemy_spawn_count > 15 and enemy_spawn_count < 30 :
			enemy_ind = 1
		if enemy_spawn_count > 30 :
			enemy_ind = 2
	# wave 4 - pre boss phase count 80
	if GameData.wave == 4 :
		enemy_ind = 3
		if enemy_spawn_count > 20 and enemy_spawn_count < 50 :
			enemy_ind = 4
	# wave 5 - boss count = 75
	if GameData.wave == 5 :
		enemy_ind = 3
		if enemy_spawn_count > 15 and enemy_spawn_count < 45 :
			enemy_ind = 4
		if enemy_spawn_count > 44 and enemy_spawn_count < 75 :
			enemy_ind = 3
		elif enemy_spawn_count == 75 :
			enemy_ind = 5
	
	var enemy_scene = enemies_array[enemy_ind]
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	timer.wait_time = difficulty_manager.get_spawn_time()



func _on_difficulty_manager_stop_spawning_enemies() -> void:
	timer.stop() 
 
