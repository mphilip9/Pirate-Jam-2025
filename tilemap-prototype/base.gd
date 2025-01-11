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
	var start_x = grass_rect.position.x
	var start_y = grass_rect.position.y + grass_rect.size.y - 6
	var middle_y = grass_rect.position.y + grass_rect.size.y / 2
	var end_x = grass_rect.position.x + grass_rect.size.x - 2
	var end_y = grass_rect.position.y + 2
	
	var start_point = Vector2i(start_x, start_y)
	var end_point = Vector2i(end_x, end_y)
	
	var waypoint1 = Vector2i(start_x + grass_rect.size.x / 3, start_y)
	var waypoint2 = Vector2i(waypoint1.x, end_y)
	
#	Generate path cells
	path_cells += generate_straight_path(start_point, waypoint1)
	path_cells += generate_straight_path(waypoint1, waypoint2)
	path_cells += generate_straight_path(waypoint2, end_point)
	print('cells here', path_cells)
	path_cells = remove_consecutive_duplicates(path_cells)

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
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
