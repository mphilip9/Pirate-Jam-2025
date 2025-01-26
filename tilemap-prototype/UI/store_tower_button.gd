extends Button
@onready var store_tower_button_texture = $StoreTowerButtonTexture

# TODO : We really only need the name and the texture from the tower stats, if we hit performance issues
# maayyyybe just using the string and texture directly would help? For now it makes my life easier though
@export var store_button_stats: TowerStats
@export var is_lock_btn: bool = false
@export var is_locked: bool

signal store_button_pressed(data: TowerStats, is_lock_btn: bool)


# Called when the node enters the scene tree for the first time.
func _ready():
	if !store_button_stats:
		printerr('Store Tower Button has no tower stats to reference!')
		return
	store_tower_button_texture.texture = store_button_stats.preview_texture
	self.pressed.connect(_store_button_pressed)
	is_locked = GameData.tower_store[store_button_stats.name].unlocked

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !store_button_stats:
		printerr('Store Tower Button has no tower stats to reference!')
		return
	if GameData.tower_store[store_button_stats.name].unlocked:
		store_tower_button_texture.modulate = Color(1,1,1,1)
	else:
		store_tower_button_texture.modulate = Color(.2,.2,.2,.2)


func _store_button_pressed():
	emit_signal("store_button_pressed", store_button_stats, is_lock_btn)
