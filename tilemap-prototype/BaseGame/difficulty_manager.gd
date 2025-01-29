extends Node

signal stop_spawning_enemies

@export var game_length := 30.0
@export var spawn_time_curve: Array[Curve]
@onready var timer: Timer = $Timer
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	timer.start(game_length)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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

func _on_timer_timeout() -> void:
	stop_spawning_enemies.emit()
