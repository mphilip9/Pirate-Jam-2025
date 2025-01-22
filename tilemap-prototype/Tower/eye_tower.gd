extends Node2D
@onready var range_collision_shape = $Range/RangeCollisionShape
@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer
@onready var range = $Range

#DO NOT NAME tower_stats, it will throw an error
@export var tower_stats: TowerStats
var enemy_path: Path2D
var current_target: CharacterBody2D
var enemies: Array[CharacterBody2D] = [] 
var projectile_cooldown: float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("idle_tower")
	range_collision_shape.shape.radius = tower_stats.range
	projectile_cooldown = tower_stats.rate_of_fire

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Remove monitoring if it is a preview tower to disable collisions
	# NOTE: We set the Resource in the Inspector to be 'Local to Scene'
	# TO ensure each copy has a unique resource attached to it. So 
	# if we edit one, we don't edit all of them
	if tower_stats.preview:
		range.monitoring = false
		return
	if current_target and is_instance_valid(current_target):
#		TODO: We could add a check here to also ensure the target is actually still in range
		projectile_cooldown -= delta
		if projectile_cooldown <= 0:
			fire(current_target)
			projectile_cooldown = tower_stats.rate_of_fire
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
	var projectile = tower_stats.projectile_scene.instantiate()
	projectile.target = target
	projectile.damage = tower_stats.damage
	projectile.speed = tower_stats.speed
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
		
		
		#
func draw_range():
	var color = Color(0, 0, 0, 0)
	draw_circle(Vector2(0,0), 100.0, color)
