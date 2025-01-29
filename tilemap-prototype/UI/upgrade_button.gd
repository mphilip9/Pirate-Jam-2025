extends Button
@export var upgrade_btn_type: String
@onready var cost = $Cost

signal upgrade_button_pressed(data: String, cost: int)


# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(_upgrade_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var selected_tower: TowerStats = GameData.selected_tower_stats
	if !selected_tower:
		return
	var multiplier = GameData.upgrade_cost_multiplier[upgrade_btn_type]
	if GameData.tower_store[selected_tower.name].upgrades[upgrade_btn_type]:
		modulate = Color(0, 1, 0, 1)
		disabled = true
		cost.text = ''
	else:
		disabled = false
		modulate = Color(1,1,1,1)
		cost.text = str(selected_tower.cost * multiplier)
		cost.set("theme_override_colors/font_color",Color.WHITE)

		# Set it to the non upgraded color or whatever
	if cost.text and int(cost.text) > GameData.mort_flesh:
		disabled = true
		cost.set("theme_override_colors/font_color",Color.RED)


func _upgrade_button_pressed():
	emit_signal("upgrade_button_pressed", upgrade_btn_type, int(cost.text))
