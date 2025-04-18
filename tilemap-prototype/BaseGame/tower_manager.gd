extends Node2D
@onready var ground = $"../Maps/Ground"
@onready var mort_flesh = $"../HUD/MarginContainer/PanelContainer/MarginContainer/ManagerHUD/MortFleshContainer/MortFlesh"

const projectile_tower = preload("res://Tower/projectile_tower.tscn")
const lazer_tower = preload("res://Tower/lazer_tower.tscn")

const towers = {
	'projectile': preload("res://Tower/projectile_tower.tscn"),
	'lazer': preload("res://Tower/lazer_tower.tscn"),
	'seismic': preload("res://Tower/seismic_tower.tscn"),
	'hand': preload("res://Tower/hand_tower.tscn"),
	'lung': preload("res://Tower/lung_tower.tscn"),
	'mouth': preload("res://Tower/mouth_tower.tscn")
}

@export var preview_tower = false
@export var preview_tower_scene: Node2D
var can_place: bool = false
var tower_to_place: String

func _ready():
	pass

func _process(delta):
	mort_flesh.text = str(GameData.mort_flesh)

func can_place_tower(pos) -> bool:
	if GameData.occupied_tiles.find(pos) != -1:
		return false
	return true
	
#	NOTE: TROUBLE PLACING TOWER? IF IT HAS A CONTROL NODE ATTACHED, SET THE MOUSE FILTER TO PASS TO ENSURE
#	IT DOESN'T HANDLE THE EVENT.
# Called when the node enters the scene tree for the first time.
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and can_place:
		var tower_scene = towers[tower_to_place].instantiate()
		
		tower_scene.position = get_global_mouse_position()
		#preview_tower_scene.get_node("RangeIndicator").visible = false
		preview_tower_scene.queue_free()
		AudioManager.play("res://Assets/SFX/009 stomp d.wav")
		get_parent().add_child(tower_scene) 
		preview_tower = false
		can_place = false
		GameData.mort_flesh -= tower_scene.tower_stats.cost
#		TODO: Young I need some help in here getting this math right. I'm wingin it here
#This is essentially marking a 2x2 area of tiles to represent the tower
		var half_size = Vector2(16, 16)  
		var top_left_pixel_pos = tower_scene.position - half_size + Vector2(8, 0)
		var top_left_tile = ground.local_to_map(top_left_pixel_pos)
		# appending w/e turret gets placed
		GameData.placed_turrets[tower_to_place] += 1
		for y in range(2):
			for x in range(2):
				GameData.occupied_tiles.append(top_left_tile + Vector2i(x, y))


func _input(event):
	if InputEventMouseMotion and preview_tower:
		preview_tower_scene.position = get_global_mouse_position()
		var local_coords = ground.local_to_map(preview_tower_scene.position)
		can_place = can_place_tower(local_coords)
		if can_place:
			preview_tower_scene.get_node("RangeIndicator").modulate = Color(0.3, 0.3, 0.3, 0.4)
		else:
			preview_tower_scene.get_node("RangeIndicator").modulate = Color(1.0, 0.0, 0.0, 0.2)
	if event.is_action_pressed("escape") or event.is_action_pressed("cancel_tower_selection"):
		if preview_tower:
			preview_tower_scene.queue_free()
			preview_tower = false
		else:
			pass
			
func place_preview_tower(tower_type: String) -> void:
	tower_to_place = tower_type
	preview_tower_scene = towers[tower_to_place].instantiate()
	preview_tower_scene.tower_stats.preview = true # This is how we disable collisions and stuff in preview mode
	if GameData.mort_flesh < preview_tower_scene.tower_stats.cost:
		return
	preview_tower = true
	preview_tower_scene.position = get_global_mouse_position()
	preview_tower_scene.modulate.a = .9
	preview_tower_scene.get_node("RangeIndicator").visible = true
	get_parent().add_child(preview_tower_scene)
	
func handle_tower_button(tower_type: String) -> void:
	if preview_tower:
		preview_tower_scene.queue_free()
		preview_tower = false
		if tower_type != tower_to_place:
			place_preview_tower(tower_type)
	else:
		place_preview_tower(tower_type)

		
	
func _on_projectile_button_pressed() -> void:
	handle_tower_button('projectile')

func _on_lazer_button_pressed():
	handle_tower_button('lazer')


func _on_seismic_button_pressed() -> void:
	handle_tower_button('seismic')


func _on_hand_button_pressed() -> void:
	handle_tower_button('hand')


func _on_lung_button_pressed() -> void:
	handle_tower_button('lung')


func _on_mouth_button_pressed() -> void:
	handle_tower_button('mouth')
