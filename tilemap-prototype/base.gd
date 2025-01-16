extends Node2D
@onready var grass = $Maps/Grass
@onready var ground = $Maps/Ground
@onready var objects = $Maps/Objects



# Called when the node enters the scene tree for the first time.
func _ready():
	var used_grass_cells = grass.get_used_cells()
	var used_ground_cells = ground.get_used_cells()
	var used_object_cells = objects.get_used_cells()
	var grass_rect = grass.get_used_rect()
#	Remove cells
	for cell in used_ground_cells:
		ground.erase_cell(cell)
	for cell in used_object_cells:
		objects.erase_cell(cell)
	var path_cells = []
	#	Code for dead simple path across the center of the map
	#for x in range(grass_rect.position.x, grass_rect.position.x + grass_rect.size.x):
		#path_cells.append(Vector2i(x, middle_y))
#	Start and end points
	var start_x = grass_rect.position.x+1
	var start_y = grass_rect.position.y + grass_rect.size.y-3
	var middle_y = grass_rect.position.y + grass_rect.size.y / 2
	var end_x = grass_rect.position.x + grass_rect.size.x -2
	var end_y = grass_rect.position.y+2
	var start_point = Vector2i(start_x, start_y)
	var end_point = Vector2i(end_x, end_y)
	print(start_x,'  ',start_y,'  ',middle_y,'  ',end_x,'  ',end_y,'  ',start_point,'  ',end_point)

	var waypoint1 = Vector2i(start_x + grass_rect.size.x / 3, start_y)
	var waypoint2 = Vector2i(waypoint1.x, end_y)
	var mapCoord = []
	for i in (start_y - end_y+1):
		mapCoord.append([])
		mapCoord[i] = []
		for j in (end_x - start_x+1):
			mapCoord[i].append([])
			mapCoord[i][j] = 0
	path_cells += easy_mapout(mapCoord,start_x,end_x,end_y,start_y)
#	print('compare',coords)
#	Generate path cells
#	path_cells += generate_straight_path(start_point, waypoint1)
#	path_cells += generate_straight_path(waypoint1, waypoint2)
#	path_cells += generate_straight_path(waypoint2, end_point)
#	print('cells here', path_cells)
	path_cells = remove_consecutive_duplicates(path_cells)
	print('cells here', path_cells)
	ground.set_cells_terrain_path(
		path_cells, 
		0,  # same terrain set
		0,       # the "ground" terrain
		 false
	)
		
func generate_straight_path(from_point, to_point):
	var path = []
	if from_point.x == to_point.x:
	#vertical movement
		var step = 1 if to_point.y > from_point.y else -1
		for y in range(from_point.y, to_point.y + step, step):
			path.append(Vector2i(from_point.x, y))
	elif from_point.y == to_point.y:
		var step = 1 if to_point.x > from_point.x else -1
		for x in range(from_point.x, to_point.x + step, step):
			path.append(Vector2i(x, from_point.y))
			
	else:
		#Diagonal!!!!
		push_error("We can't handle non-straight paths you fuggin bozo")
	return path 

func remove_consecutive_duplicates(path):
	var cleaned_path = []
	for cell in path:
		if len(cleaned_path) == 0 or cleaned_path[-1] != cell:
			cleaned_path.append(cell)
	return cleaned_path

func easy_mapout(matrix_input,start_x, end_x, start_y, end_y):
	var max_x_ind = end_x -start_x 
	var max_y_ind = end_y - start_y
	print(max_x_ind,max_y_ind)
	# path collecting array
	var path_array = []
	#set random start point
	var curr_point = [(randi_range(0,max_y_ind)),0] #y,x coord
	matrix_input[curr_point[0]][0] = 1;

	path_array.append(Vector2i(start_x,curr_point[0]+start_y)) # x, y coord
	# save choice of direction and last direction to avoid overlap
	var poss_direction = ['r','t','b']
	var last_direction = ''
	# loop the matrix to find path
	while curr_point[1] < max_x_ind :
		var chosen_path = poss_direction[randi_range(0,2)]
		print(curr_point, chosen_path)
		#top
		if chosen_path == 't':
			if curr_point[0] < 4 or last_direction == 't' or last_direction == 'b' :
				chosen_path = 'r'
				print('switched to r')
			else :
				var trav_dis = randi_range(3, curr_point[0]);
				curr_point[0]-=1
				for i in range(curr_point[0],curr_point[0] - trav_dis, -1) :
					matrix_input[i][curr_point[1]] =1
					path_array.append(Vector2i(start_x+curr_point[1],start_y+i))
				curr_point[0] -= trav_dis - 1
				last_direction = 't'
		#bot
		if chosen_path == 'b' :
			if curr_point[0] > max_y_ind -4 or last_direction == 't' or last_direction == 'b':
				chosen_path = 'r'
				print('switched to r')
			else :
				var trav_dis = randi_range(3, max_y_ind -curr_point[0])
				curr_point[0] += 1
				for i in range(curr_point[0], curr_point[0] + trav_dis) :
					matrix_input[i][curr_point[1]] = 1;
					path_array.append(Vector2i(start_x + curr_point[1], start_y +i))
				curr_point[0] += trav_dis -1
				last_direction = 'b'
		#right
		if chosen_path == 'r':
			# for reaching max x ind
			if curr_point[1] > max_x_ind -3 :
				if curr_point[1] != max_x_ind :
					for i in range(curr_point[1], max_x_ind) :
						matrix_input[curr_point[0]][i] = 1;
						path_array.append(Vector2i(start_x+i, start_y+curr_point[0]))
				matrix_input[curr_point[0]][max_x_ind] = 1
				path_array.append(Vector2i(start_x + max_x_ind, start_y+curr_point[0]))
				curr_point[1] = max_x_ind;
			else :
				curr_point[1] += 1
				for i in range(curr_point[1], curr_point[1]+3) :
					matrix_input[curr_point[0]][i] = 1;
					path_array.append(Vector2i(start_x + i, start_y + curr_point[0]))
				last_direction = 'r'
				curr_point[1] += 2
	print(path_array)
	return path_array
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
