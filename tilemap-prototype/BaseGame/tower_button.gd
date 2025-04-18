extends TextureButton

@export var button_stats: TowerStats
@onready var tower_button_label = $TowerButtonLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	texture_normal = button_stats.preview_texture
	texture_hover = button_stats.preview_texture
	tower_button_label.text = str(button_stats.cost)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameData.mort_flesh < button_stats.cost:
		tower_button_label.set("theme_override_colors/font_color", Color.RED)
	else:
		tower_button_label.remove_theme_color_override("font_color")

#This stuff modulates the parent PanelContainer opacity on hover essentially
#TODO: Maybe show a tooltip on hover somewhere with some deets on the tower
func _on_mouse_entered():
	get_parent().modulate = Color(1,1,1,.8)


func _on_mouse_exited():
	get_parent().modulate = Color(1,1,1,1)
