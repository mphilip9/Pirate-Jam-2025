extends Control
@onready var scene_transition = $SceneTransition


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# load base_level.tscn when start button pressed
func _on_start_pressed() :
	AudioManager.adjust_pitch(1.0)
	AudioManager.adjust_volume(-8.0)
	AudioManager.play("res://Assets/SFX/013 JESTER SNARE.wav")
	get_tree().change_scene_to_file("res://UI/StoryTime.tscn")

# exit out game when pressed
func _on_quit_pressed() -> void:
	get_tree().quit()
