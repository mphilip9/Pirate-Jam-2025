extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# load base_level.tscn when start button pressed
func _on_start_pressed() :
	get_tree().change_scene_to_file("res://BaseGame/base_level.tscn")

# exit out game when pressed
func _on_quit_pressed() -> void:
	get_tree().quit()
