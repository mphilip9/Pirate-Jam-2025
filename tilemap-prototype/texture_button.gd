extends Control
@onready var button = $Button

@export var button_data: TowerStats

# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect(_on_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	print('wow we did it cool')
