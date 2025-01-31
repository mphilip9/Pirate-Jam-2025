extends PanelContainer

@onready var game_over_animation = $GameOverAnimation
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
	GameData.restore_game_data()
	get_tree().change_scene_to_file("res://BaseGame/base_level.tscn")

func _on_quit_to_menu_button_pressed():
	get_tree().paused = false
	GameData.restore_game_data()
	get_tree().change_scene_to_file("res://UI/StartScreen.tscn")
