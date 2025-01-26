extends Button
@onready var store_tower_button_texture = $StoreTowerButtonTexture

# TODO : We really only need the name and the texture from the tower stats, if we hit performance issues
# maayyyybe just using the string and texture directly would help? For now it makes my life easier though
@export var store_button_stats: TowerStats
@export var lock_button: bool = false

signal store_button_pressed(data)


# Called when the node enters the scene tree for the first time.
func _ready():
	store_tower_button_texture.texture = store_button_stats.preview_texture
	self.pressed.connect(_store_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _store_button_pressed():
	emit_signal("store_button_pressed", store_button_stats)
