extends Node2D
@onready var range_collision_shape = $Range/RangeCollisionShape
@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer

#DO NOT NAME tower_stats, it will throw an error
@export var eye_tower_stats: TowerStats
var enemy_path: Path2D
var current_target: CharacterBody2D
var enemies: Array[CharacterBody2D] = [] 
var projectile_cooldown: float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("idle_tower")
	range_collision_shape.shape.radius = eye_tower_stats.range
	projectile_cooldown = eye_tower_stats.rate_of_fire

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_target and is_instance_valid(current_target):
#		TODO: We could add a check here to also ensure the target is actually still in range
		projectile_cooldown -= delta
		if projectile_cooldown <= 0:
			fire(current_target)
			projectile_cooldown = eye_tower_stats.rate_of_fire
	else: 
		current_target = null
		find_best_target()

#TODO: Consider logic for how to choose which enemy to target
func find_best_target() -> void:
	if len(enemies) > 0:
		current_target = enemies[0]
#		Remove the enemy from the array so we don't try to add it later
		enemies.pop_front()

func fire(target: CharacterBody2D):
	var projectile = eye_tower_stats.projectile_scene.instantiate()
	projectile.target = target
	projectile.damage = eye_tower_stats.damage
	projectile.speed = eye_tower_stats.speed
	add_child(projectile)
func _on_range_body_entered(body):
	#print('body here', body, body.get_parent())
	#fire(body)
	if !current_target:
		current_target = body
	else:
		enemies.append(body)


func _on_range_body_exited(body):
	enemies.erase(body)
	if current_target == body:
		current_target = null
		
