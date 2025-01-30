extends Node

signal stop_spawning_enemies
@onready var wave_warning_animation = $"../HUD/WaveWarningContainer/WaveWarningAnimation"
@onready var wave_warning_label = $"../HUD/WaveWarningContainer/WaveWarningLabel"
@onready var enemy_spawn_timer = $"../Path2D/EnemySpawnTimer"
@onready var scene_transition = $"../SceneTransition"

@export var game_length := 30.0
@export var spawn_time_curve: Array[Curve]
@onready var timer: Timer = $Timer
var waves_per_stage = 2
# Called when the node enters the scene tree for the first time.

signal handle_final_wave()

func _ready() -> void:
	handle_wave_warning()
	timer.start(game_length)
#	TODO: Revisit this logic when we can have more than 5 waves per stage
	if GameData.stage < 3:
		waves_per_stage += GameData.stage
#	We could do something similar for game_length if we wanted


func game_progress_ratio() -> float:
	return 1.0 - (timer.time_left / game_length) # we want this to start at 0.0 and end at 1.0

func get_spawn_time() -> float:
	var curveIndex: int = 0
	if GameData.wave < 4 :
		curveIndex = 0
	elif GameData.wave == 4 :
		curveIndex = 1
	else :
		curveIndex = 2
	
	return spawn_time_curve[curveIndex].sample(game_progress_ratio()) # this will grab the spawn time value relative to the graph as the level goes on

func handle_wave_warning() -> void:
	wave_warning_label.text = 'Stage: ' + str(GameData.stage) + '   Wave ' + str(GameData.wave) + ' Incoming'
	wave_warning_animation.play('wave_warning')


#Something is off here, but I'm on the right track I think
func start_new_wave() -> void:
	GameData.wave += 1
	handle_wave_warning()
	timer.start(game_length)
#	TODO: Consider the best time to wait between scene endings
#	TODO: This timer should not start until the last enemy is dead. Maybe a signal from the path2d??
	enemy_spawn_timer.start(30)
		



func _on_timer_timeout() -> void:
	stop_spawning_enemies.emit()
	if GameData.wave < waves_per_stage:
		start_new_wave()
	else: 
		handle_final_wave.emit()
