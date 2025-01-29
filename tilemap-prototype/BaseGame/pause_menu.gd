extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pause_button_toggled(toggled_on: bool) -> void:
	AudioManager.play("res://Assets/SFX/013 JESTER SNARE.wav")
	visible = toggled_on



	

func _on_resume_button_pressed() -> void:
	AudioManager.play("res://Assets/SFX/013 JESTER SNARE.wav")
	visible = false
