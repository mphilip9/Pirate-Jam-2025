extends Node2D
@onready var ground = $"../Maps/Ground"

const tower = preload("res://Tower/eye_tower.tscn")
@export var preview_tower = false
@export var preview_tower_scene: Node2D
var can_place: bool = false

func can_place_tower(pos) -> bool:
	#var offset_cells = [
		#Vector2i(0,0),
		#Vector2i(1,0),
		#Vector2i(-1, 0),
		#Vector2i(0,1),
		#Vector2i(0,-1)
	#]
	#for offset in offset_cells:
		#var neighbor_cell = pos + offset
		#
	if GameData.occupied_tiles.find(pos) != -1:
		return false
	return true
# Called when the node enters the scene tree for the first time.
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and can_place:
		var tower_scene = tower.instantiate()
		tower_scene.position = get_global_mouse_position()
		#preview_tower_scene.get_node("RangeIndicator").visible = false
		preview_tower_scene.queue_free()
		get_parent().add_child(tower_scene) 
		preview_tower = false
		can_place = false
		GameData.mort_flesh -= tower_scene.tower_stats.cost
#		TODO: Young I need some help in here getting this math right. I'm wingin it here
#This is essentially marking a 2x2 area of tiles to represent the tower
		var half_size = Vector2(16, 16)  
		var top_left_pixel_pos = tower_scene.position - half_size + Vector2(8, 0)
		var top_left_tile = ground.local_to_map(top_left_pixel_pos)
		for y in range(2):
			for x in range(2):
				GameData.occupied_tiles.append(top_left_tile + Vector2i(x, y))
	elif InputEventMouseMotion and preview_tower:
		preview_tower_scene.position = get_global_mouse_position()
		var local_coords = ground.local_to_map(preview_tower_scene.position)
		can_place = can_place_tower(local_coords)
		if can_place:
			preview_tower_scene.get_node("RangeIndicator").modulate = Color(0.0, 1.0, 0.0, 0.2)
		else:
			preview_tower_scene.get_node("RangeIndicator").modulate = Color(1.0, 0.0, 0.0, 0.2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#TODO: Ideally this would be done in a script. We 
# should generate each button and attach a signal for the different towers
func _on_button_pressed():
	if (preview_tower):
			preview_tower_scene.queue_free()
			preview_tower = false
	else:
		preview_tower_scene = tower.instantiate()
		preview_tower_scene.tower_stats.preview = true
		if GameData.mort_flesh < preview_tower_scene.tower_stats.cost:
			return
#		TODO: Disable collision stuff on preview towers
		preview_tower = true
		preview_tower_scene.position = get_global_mouse_position()
		preview_tower_scene.modulate.a = .9
		preview_tower_scene.get_node("RangeIndicator").visible = true
		get_parent().add_child(preview_tower_scene)
