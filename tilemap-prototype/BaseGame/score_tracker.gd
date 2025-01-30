extends MarginContainer
@onready var score = $PanelContainer/MarginContainer/ScoreContainer/ScoreContainer/Score
@onready var kills = $PanelContainer/MarginContainer/ScoreContainer/KillContainer/Kills
@onready var wave = $PanelContainer/MarginContainer/ScoreContainer/WaveContainer/Wave
@onready var stage = $PanelContainer/MarginContainer/ScoreContainer/StageContainer/Stage


# Called when the node enters the scene tree for the first time.
func _ready():
	score.text = str(GameData.score)
	kills.text = str(GameData.kills)
	wave.text = str(GameData.wave)
	stage.text = str(GameData.stage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score.text = str(GameData.score)
	kills.text = str(GameData.kills)
	wave.text = str(GameData.wave)
	stage.text = str(GameData.stage)
