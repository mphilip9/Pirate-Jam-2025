extends Node

var num_players = 10
var bus = "master"

var available = []  # The available players.
var queue = []  # The queue of sounds to play.
var has_been_pitched := false

func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var player = AudioStreamPlayer.new()
		var pitch_scale = randf_range(0.8, 1.2)
		if (!has_been_pitched):
			player.set_pitch_scale(pitch_scale)
			has_been_pitched = false
		add_child(player)
		available.append(player)
		player.finished.connect(_on_stream_finished.bind(player))
		player.bus = bus


func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)


func play(sound_path):
	queue.append(sound_path)

func adjust_volume(volume: float):
	available[0].set_volume_db(volume)

func adjust_pitch(pitch: float):
	available[0].set_pitch_scale(pitch)
	has_been_pitched = true

func stop_all() -> void:
	queue.clear()
	available.clear()
	
func _process(delta):
	# Play a queued sound if any players are available.
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()
