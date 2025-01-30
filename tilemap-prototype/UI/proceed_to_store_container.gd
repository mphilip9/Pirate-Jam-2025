extends MarginContainer
@onready var scene_transition = $"../../SceneTransition"


func transition_to_store() -> void:
	for name in GameData.placed_turrets :
		if name == 'projectile':
			GameData.mort_flesh += GameData.placed_turrets[name] * 40
		if name == 'lazer':
			GameData.mort_flesh += GameData.placed_turrets[name] * 80
		if name == 'seismic':
			GameData.mort_flesh += GameData.placed_turrets[name] * 60
		if name == 'hand':
			GameData.mort_flesh += GameData.placed_turrets[name] * 40
		if name == 'lung':
			GameData.mort_flesh += GameData.placed_turrets[name] * 100
		GameData.placed_turrets[name] = 0
	scene_transition.change_scene("res://UI/tower_store.tscn")
	GameData.wave = 1
	GameData.stage += 1


func _on_proceed_to_store_button_pressed():
	transition_to_store()
