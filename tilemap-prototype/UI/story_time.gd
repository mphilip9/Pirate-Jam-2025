extends Control

func _on_button_pressed():
	print('hello')
	AudioManager.adjust_pitch(1.0)
	AudioManager.adjust_volume(-8.0)
	AudioManager.play("res://Assets/SFX/208 witchlaughter.wav")
	get_tree().change_scene_to_file("res://BaseGame/base_level.tscn")
