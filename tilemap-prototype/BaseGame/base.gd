extends Node2D
@onready var ene_path = $Path2D
@onready var grass = $Maps/Grass
@onready var ground = $Maps/Ground
@onready var objects = $Maps/Objects
const tower = preload("res://Tower/eye_tower.tscn")
@export var preview_tower = false
@export var preview_tower_scene: Node2D

@onready var castle = $Castle

# Called when the node enters the scene tree for the first time.
func _ready():
	var used_grass_cells = grass.get_used_cells()
	var grass_rect = grass.get_used_rect()
	var path_cells = []
	
	# Start and end points
	var start_x = grass_rect.position.x+2
	var start_y = grass_rect.position.y + grass_rect.size.y-8
	var end_x = grass_rect.position.x + grass_rect.size.x -10
	var end_y = grass_rect.position.y+8
	# use easy_mapout function for coordinates
	path_cells += easy_mapout(start_x,end_x,end_y,start_y,0)
	path_cells = remove_consecutive_duplicates(path_cells)
	castle.position = Vector2(castle.position.x, (path_cells[-1].y-2.5)*16 )
	ene_path.curve.clear_points()
	# set enenmy path according to the path_cells
	for i in path_cells :
		ene_path.curve.add_point(Vector2(i)*16)
		GameData.occupied_tiles.append(i)
	ground.set_cells_terrain_path(
		path_cells, 
		0,  # same terrain set
		0,       # the "ground" terrain
		 false
	)
	
func can_place_tower(pos) -> bool:
	var offset_cells = [
		Vector2i(0,0),
		Vector2i(1,0),
		Vector2i(-1, 0),
		Vector2i(0,1),
		Vector2i(0,-1)
	]
	for offset in offset_cells:
		var neighbor_cell = pos + offset
		
		if GameData.occupied_tiles.find(neighbor_cell) != -1:
			return false
	return true
#	Produce coords above and below, right and left of pos
# Check if any of those coords are in the occupied_tiles
#if yes, return false, else return true

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and preview_tower:
		var tower_scene = tower.instantiate()
		tower_scene.position = get_global_mouse_position()
		var local_coords = ground.local_to_map(tower_scene.position)
		print(can_place_tower(local_coords))
		add_child(tower_scene)
		preview_tower = false
	elif InputEventMouseMotion and preview_tower:
		preview_tower_scene.position = get_global_mouse_position()
#		enter key
		
	

func remove_consecutive_duplicates(path):
	var cleaned_path = []
	for cell in path:
		if len(cleaned_path) == 0 or cleaned_path[-1] != cell:
			cleaned_path.append(cell)
	return cleaned_path

func easy_mapout(start_x, end_x, start_y, end_y, start_coord):
	var max_x_ind = end_x - start_x 
	var max_y_ind = end_y - start_y
	# path collecting array
	var path_array = []
	var curr_point = start_coord
	#set random start point unless specified
	if start_coord == 0 :
		curr_point = [(randi_range(0,max_y_ind)),0] #y,x coord
	path_array.append(Vector2i(start_x - 1,curr_point[0] + start_y))
	path_array.append(Vector2i(start_x, curr_point[0] + start_y)) # x, y coord
	# save choice of direction and last direction to avoid overlap
	var poss_direction = ['r','t','b']
	var last_direction = ''
	# loop the matrix to find path
	while curr_point[1] < max_x_ind :
		# choos randomly from the poss_direction
		var chosen_path = poss_direction[randi_range(0,2)]
		#top
		if chosen_path == 't':
			# condition to avoid overlap or going over, and to make it faster pass it to right if statisfied
			if curr_point[0] < 4 or last_direction == 't' or last_direction == 'b' :
				chosen_path = 'r'
			else :
				# start traversing and collecting the path
				var trav_dis = randi_range(3, curr_point[0]);
				curr_point[0]-=1
				for i in range(curr_point[0],curr_point[0] - trav_dis, -1) :
					path_array.append(Vector2i(start_x + curr_point[1], start_y + i))
				curr_point[0] -= trav_dis - 1
				last_direction = 't'
		#bot : same logic as above
		if chosen_path == 'b' :
			if curr_point[0] > max_y_ind -4 or last_direction == 't' or last_direction == 'b':
				chosen_path = 'r'
			else :
				var trav_dis = randi_range(3, max_y_ind -curr_point[0])
				curr_point[0] += 1
				for i in range(curr_point[0], curr_point[0] + trav_dis) :
					path_array.append(Vector2i(start_x + curr_point[1], start_y +i))
				curr_point[0] += trav_dis -1
				last_direction = 'b'
		#right
		if chosen_path == 'r':
			# for reaching max x ind to end the while loop
			if curr_point[1] > max_x_ind -4 : # 
				if curr_point[1] != max_x_ind :
					for i in range(curr_point[1], max_x_ind) :
						path_array.append(Vector2i(start_x+i, start_y+curr_point[0]))
				path_array.append(Vector2i(start_x + max_x_ind, start_y+curr_point[0]))
				curr_point[1] = max_x_ind;
			else :
				curr_point[1] += 1
				for i in range(curr_point[1], curr_point[1]+4) :
					path_array.append(Vector2i(start_x + i, start_y + curr_point[0]))
				last_direction = 'r'
				curr_point[1] += 3
	return path_array
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if (preview_tower):
			preview_tower_scene.queue_free()
			preview_tower = false
	else:
		preview_tower = true
		preview_tower_scene = tower.instantiate()
		preview_tower_scene.position = get_global_mouse_position()
		add_child(preview_tower_scene)
