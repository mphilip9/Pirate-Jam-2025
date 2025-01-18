extends Path2D

@onready var path_follow = $PathFollow2D
@onready var ene_animation = $PathFollow2D/EnemySpirte/body
@export var enemy_scene: PackedScene
var ene_speed = 100
var last_fram_pos = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('making an enemy')
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
