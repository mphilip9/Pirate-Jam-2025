extends Node2D

@onready var label: Label = $ProgressBar/Label
@onready var progress_bar = $ProgressBar
@export var max_health: int = 50

signal game_over()

var current_health: int:
	set(health_in):
		current_health = health_in
		var current_health_to_str: String
		if current_health < 10:
			#TODO: have to fix this if the health is higher than 2 digit
			# so that the text doesnt look like its moving when the health is 10th or lower
			current_health_to_str = "  "+str(current_health)
		else :
			current_health_to_str = str(current_health)
		label.text = current_health_to_str + "/" + str(max_health)
		progress_bar.value = current_health
		var red: Color = Color.RED
		var yellow: Color = Color.YELLOW
		# access progressbar background style property
		var progress_bar_style = progress_bar.get_theme_stylebox("background")
		# change bg_color from yellow to red to indicate how low the health is
		progress_bar_style.bg_color = red.lerp(yellow,float(current_health) / float(max_health))
		if current_health < 1:
			game_over.emit()
			# TODO: gotta make them retry or make a defeat menu load on castle death
			# just reload
			#get_tree().reload_current_scene()
			# go back to start screen
			#get_tree().change_scene_to_file("res://StartScreen/StartScreen.tscn")
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health

func take_damage(damage: int) :
	AudioManager.play("res://Assets/SFX/Rock Impact 11.wav")
	current_health -= damage
