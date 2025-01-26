extends PanelContainer

var selected_tower: TowerStats
var is_lock_btn: bool
@onready var unlock_button = $PanelContainer/VBoxContainer/SplitContainer/TowerUnlock/PanelContainer2/MarginContainer/UnlockButton
@onready var money_label = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/MoneyContainer/MoneyLabel
@onready var upgrade_but_container = $PanelContainer/VBoxContainer/SplitContainer/TowerUpgrades/PanelContainer3/MarginContainer/PanelContainer/UpgradeButContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect to to all the tower upgrade/unlock buttons
	for button in get_tree().get_nodes_in_group("tower_store_buttons"):
		if button.has_signal("store_button_pressed"):
			button.store_button_pressed.connect(self._on_store_button_pressed)
		if button.has_signal("upgrade_button_pressed"):
			print('hitting the upgrade button signal')
			button.upgrade_button_pressed.connect(self._on_upgrade_button_pressed)
	

#Determine tower store stats for the selected tower
func get_tower_store_stats(tower_type: String):
	pass
	
	pass

func toggle_update_buttons():
	var tower_upgrades = GameData.tower_store[selected_tower].upgrades
	if tower_upgrades.range:
		pass
	if tower_upgrades.rate_of_fire:
		pass
	if tower_upgrades.damage:
		pass
	
	
func toggle_unlock_button():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	money_label.text = str(GameData.mort_flesh)
#	Here we continuosly check for updates for what is unlocked and upgraded
	pass

func _on_store_button_pressed(data: TowerStats, is_lock_btn: bool):
	GameData.selected_tower_stats = data
	selected_tower = data
	is_lock_btn = is_lock_btn

func _on_upgrade_button_pressed(upgrade_type: String, cost: int):
	if selected_tower and !is_lock_btn:
		GameData.tower_store[selected_tower.name].upgrades[upgrade_type] = true
		GameData.mort_flesh -= cost
		
#
#func _on_range_button_pressed():
	#if selected_tower and !is_lock_btn:
		#GameData.tower_store[GameData.selected_tower_type].upgrades.range = true
#
#
#func _on_damage_button_pressed():
	#if selected_tower and !is_lock_btn:
		#GameData.tower_store[GameData.selected_tower_type].upgrades.damage = true
#
#
#func _on_rof_button_pressed():
	#if selected_tower and !is_lock_btn:
		#GameData.tower_store[GameData.selected_tower_type].upgrades.rate_of_fire = true
