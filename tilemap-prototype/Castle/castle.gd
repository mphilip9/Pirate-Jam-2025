extends Node2D

@export var max_health: int = 50

var current_health: int:
	set(health_in):
		current_health = health_in
		label.text = str(current_health) + "/" + str(max_health)
		var red: Color = Color.RED
		var white: Color = Color.WHITE
		label.modulate = red.lerp(white,float(current_health) / float(max_health))
		if current_health < 1:
			get_tree().reload_current_scene()
@onready var label: Label = $Label
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	current_health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.

func take_damage(damage) :
	current_health -= damage
