extends Path2D
@onready var scene_transition = $"../SceneTransition"
@onready var proceed_to_store_container = $"../HUD/ProceedToStoreContainer"
@export var difficulty_manager: Node
@onready var timer: Timer = $EnemySpawnTimer
@export var enemies_array: Array[PackedScene]
var enemy_spawn_count: int = 0
var final_wave: bool = false



func _process(delta):
	if final_wave:
		if GameData.enemy_count == 0:
			final_wave = false
			proceed_to_store_container.visible = true

			
func spawn_enemy() -> void:
	enemy_spawn_count += 1
	var enemy_ind: int = 0
	# TODO: need a better way to manage what spawn. feels like there is an easier way
	# wave 2 count 40
	if GameData.wave == 2 :
		enemy_ind = randi_range(0,1)
	# wave 3 count 40
	if GameData.wave == 3 :
		enemy_ind = randi_range(0,2)
	# wave 4 - pre boss phase count 80
	if GameData.wave == 4 :
		enemy_ind = randi_range(0,4)
	# wave 5 - boss count = 95
	if GameData.wave == 5 :
		if enemy_spawn_count % 20 == 0 :
			enemy_ind = 5
			if GameData.stage >= 5 and GameData.stage < 8 :
				enemy_ind = randi_range(5,6)
			elif GameData.stage > 7 :
				enemy_ind = randi_range(5,7)
		else :
			enemy_ind = randi_range(0,4)
		
	
	var enemy_scene = enemies_array[enemy_ind]
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	timer.wait_time = difficulty_manager.get_spawn_time()



func _on_difficulty_manager_stop_spawning_enemies() -> void:
	timer.stop() 

 


func _on_difficulty_manager_handle_final_wave():
	var delay_timer = get_tree().create_timer(5)
	await delay_timer.timeout
	final_wave = true
