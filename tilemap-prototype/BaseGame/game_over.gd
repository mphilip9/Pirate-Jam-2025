extends PanelContainer

@onready var game_over_animation = $GameOverAnimation
@onready var scene_transition = $"../../SceneTransition"
@onready var game_music_playlist = $"../../GameMusicPlaylist"
@onready var game_over_music = $GameOverMusic

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS


func _on_castle_game_over():
	game_music_playlist.stop()
	AudioManager.stop_all()
	game_over_music.play()
	game_over_animation.play('game_over_fade')
	get_tree().paused = true


func _on_new_game_button_pressed():
	get_tree().paused = false
	GameData.wave = 1
	GameData.stage = 1
	scene_transition.change_scene("res://BaseGame/base_level.tscn")

func _on_quit_to_menu_button_pressed():
	get_tree().paused = false
	scene_transition.change_scene("res://UI/StartScreen.tscn")
