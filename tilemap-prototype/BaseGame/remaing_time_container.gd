extends PanelContainer

@onready var remaining_t_label = $MarginContainer/HBoxContainer/RemainingTime
@onready var skip_button = $MarginContainer/HBoxContainer/Skip
@onready var cooldown_timer = $"../../DifficultyManager/CooldownTimer"
@onready var remaing_time_container = $"."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cooldown_timer.time_left == 0 :
		remaining_t_label.text = '  '
	else :
		remaining_t_label.text = 'New Wave Coming in ' + str(int(cooldown_timer.time_left))

func _on_skip_pressed() -> void:
	cooldown_timer.stop()	
	cooldown_timer.emit_signal("timeout")
