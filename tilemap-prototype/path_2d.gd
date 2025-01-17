extends Path2D

@onready var path_follow = $PathFollow2D

var ene_speed = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress += ene_speed * delta
