extends Node2D
@onready var range_collision_shape = $Range/RangeCollisionShape

@export var tower_stats: TowerStats

# Called when the node enters the scene tree for the first time.
func _ready():
	range_collision_shape.shape.radius = tower_stats.range


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_range_body_entered(body):
	print('enemy has entered the range')


func _on_range_body_exited(body):
	print('enemy has left the towers range')
