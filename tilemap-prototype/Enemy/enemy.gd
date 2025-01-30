class_name Enemy
extends PathFollow2D

@onready var animation_player: AnimationPlayer = $Sprite/Body/AnimationPlayer
@onready var castle = get_tree().get_first_node_in_group("base")
@export var stats: EnemyStats
@onready var body: AnimatedSprite2D = $Sprite/Body

# enemy modifier
var speed_modifier: float = 1.00
var speed_cc_frame: int = 0
# TODO: need to think about how DoT mechanism works when multiple were applied
# for now it refreshes DoT when applied
var dot_modifier: Array[int] = [0, 0] # duration, damage/tick 
var is_dying: bool = false

func die() -> void:
	if is_dying:
		return
	is_dying = true
	GameData.enemy_count -= 1
	queue_free()
	
var current_health: int:
	set(health_in):
		if health_in < current_health:
			animation_player.play("take_damage")
		current_health = health_in
		if current_health < 1:
			#GameData.enemy_count -= 1
			AudioManager.adjust_volume(-10.0)
			AudioManager.play(stats.death_sound)
			GameData.mort_flesh += stats.gold_value
			GameData.score += stats.gold_value
			GameData.kills += 1
			die()

var last_fram_pos = Vector2()

func _ready() -> void:
	# now health scale with stage number increase by 10%(additive not geometric)
	current_health = stats.max_health * (1 + (GameData.stage - 1) *0.1)
	GameData.enemy_count += 1

	
func _process(delta: float) -> void:
	# check dot_modifier if DoT is present
	if dot_modifier[0] > 0 :
	# DoT is applied when duration is of even #
		if dot_modifier[0] % 3 == 0 :
			take_damage(dot_modifier[1])
		dot_modifier[0] -= 1
		if dot_modifier[0] < 1:
			dot_modifier = [0, 0]
	# check cc frame duration deduction one every delta
	if speed_cc_frame > 0 :
		speed_cc_frame -= 1
	# when speed cc frame duration is 0 set modifier to 1.00
		if speed_cc_frame < 1:
			speed_modifier = 1.00
	# progress is the metric the PathFollow3D node uses to track where it is along its parent Path
	progress += delta * stats.speed * speed_modifier

	# current_health -= 1
	var diff_vector = position - last_fram_pos
	if diff_vector.x != 0 :
		body.play("right")
	
	elif diff_vector.y != 0 :
		if diff_vector.y > 0 :
			body.play("down")
		
		elif diff_vector.y < 0 :
			body.play("up")

	last_fram_pos = position
	if progress_ratio == 1.0:
		castle.take_damage(stats.damage)
		set_process(false)
		die()
		
		
func take_damage(damage) -> void:
	current_health -= damage

# Damage over Time
func damage_over_time(frame: int, damage: int) -> void:
	dot_modifier = [frame * 3 , roundi(damage/frame)]

# when slow cced
func crowd_control_slow(frame: int, rate: float) -> void:
	speed_cc_frame = frame
	# bosses will have resistance of 1 so it wont get CCed
	speed_modifier = 1.00 - rate * (1 - stats.resistance)
	

#TODO: This is janky right now. Needs some work
#If we keep it, big enemies should be unaffected
func push_backwards(distance: float) -> void:
	progress -= distance
	# Ensure progress doesn't go below 0
	if progress < 0:
		progress = 0
