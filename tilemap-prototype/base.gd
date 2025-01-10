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
	var middle_y = grass_rect.position.y + grass_rect.size.y / 2
	for x in range(grass_rect.position.x, grass_rect.position.x + grass_rect.size.x):
		path_cells.append(Vector2i(x, middle_y))
	print(path_cells)
	ground.set_cells_terrain_path(
		path_cells, 
		0,  # same terrain set
		0,       # the "ground" terrain
		 false
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
