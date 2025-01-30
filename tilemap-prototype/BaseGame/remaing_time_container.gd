extends PanelContainer

@onready var remaining_t_label = $HBoxContainer/RemainingTime
@onready var skip_button = $HBoxContainer/Skip
@onready var enemy_spawn_timer = $"../../Path2D/EnemySpawnTimer"
@onready var start_counter_timer = $HBoxContainer/Skip/StartCounter

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start_counter_timer.time_left == 0 :
		remaining_t_label.text = '  '
	else :
		remaining_t_label.text = str(int(start_counter_timer.time_left))
	

func enable_skip_button(wait_time) -> void:
	start_counter_timer.start(wait_time)
	skip_button.disabled = false


func _on_skip_pressed() -> void:
	print("hello?")
	skip_button.disabled = true
	start_counter_timer.stop()
	enemy_spawn_timer.start()
