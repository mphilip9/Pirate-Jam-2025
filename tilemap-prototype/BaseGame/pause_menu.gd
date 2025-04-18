extends PanelContainer
@onready var muteButton = $MenuOptions/MenuButtons/MuteContainer/MuteButton

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

func _on_mute_button_pressed():
	GameData.muted = !GameData.muted
	if GameData.muted:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		muteButton.text = "UNMUTE"
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		muteButton.text = "MUTE"
