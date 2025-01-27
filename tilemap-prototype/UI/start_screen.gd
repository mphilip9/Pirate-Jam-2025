extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# load base_level.tscn when start button pressed
func _on_start_pressed() :
	get_tree().change_scene_to_file("res://BaseGame/base_level.tscn")
	GameData.mort_flesh = 200

# exit out game when pressed
func _on_quit_pressed() -> void:
	get_tree().quit()
