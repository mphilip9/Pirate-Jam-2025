extends PanelContainer

var selected_tower: TowerStats
var is_lock_btn: bool
@onready var money_label = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/MoneyContainer/MoneyLabel
@onready var upgrade_btn_container = $PanelContainer/VBoxContainer/SplitContainer/TowerUpgrades/PanelContainer3/MarginContainer/PanelContainer/UpgradeBtnContainer
@onready var unlock_container = $PanelContainer/VBoxContainer/SplitContainer/TowerUpgrades/PanelContainer3/MarginContainer/PanelContainer/UnlockContainer
@onready var unlock_cost = $PanelContainer/VBoxContainer/SplitContainer/TowerUpgrades/PanelContainer3/MarginContainer/PanelContainer/UnlockContainer/UnlockCost
@onready var nothing_selected = $PanelContainer/VBoxContainer/SplitContainer/TowerUpgrades/PanelContainer3/MarginContainer/PanelContainer/NothingSelected
#Tower Details
@onready var tower_details = $PanelContainer/VBoxContainer/SplitContainer/TowerDetails
@onready var tower_details_image = $PanelContainer/VBoxContainer/SplitContainer/TowerDetails/TowerInfo/MarginContainer/HBoxContainer/TowerDetailsImage
@onready var tower_title = $PanelContainer/VBoxContainer/SplitContainer/TowerDetails/TowerInfo/MarginContainer/HBoxContainer/TowerTitle
@onready var tower_info_blurb = $PanelContainer/VBoxContainer/SplitContainer/TowerDetails/TowerInfo/MarginContainer/HBoxContainer/TowerInfoBlurb


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect to to all the tower upgrade/unlock buttons
	for button in get_tree().get_nodes_in_group("tower_store_buttons"):
		if button.has_signal("store_button_pressed"):
			button.store_button_pressed.connect(self._on_store_button_pressed)
		if button.has_signal("upgrade_button_pressed"):
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
	
	
#	Here we continuosly check for updates for what is unlocked and upgraded
func _process(delta):
	money_label.text = str(GameData.mort_flesh)
	if !selected_tower:
		return
	#	Toggle unlock vs upgrade buttons
	elif !GameData.tower_store[selected_tower.name].unlocked:
		upgrade_btn_container.visible = false
		unlock_container.visible = true
	elif GameData.tower_store[selected_tower.name].unlocked:
		upgrade_btn_container.visible = true
		unlock_container.visible = false
	tower_details.visible = true
	tower_details_image.texture = selected_tower.preview_texture
	tower_title.text = selected_tower.name
	tower_info_blurb.text = selected_tower.info
		

func _on_store_button_pressed(data: TowerStats, is_lock_btn: bool):
	AudioManager.adjust_pitch(1)
	AudioManager.play("res://Assets/SFX/028 TAMBO SHORT.wav")
	GameData.selected_tower_stats = data
	selected_tower = data
	is_lock_btn = is_lock_btn
	unlock_cost.text = str(data.cost)
	nothing_selected.visible = false

func _on_upgrade_button_pressed(upgrade_type: String, cost: int):
	if selected_tower and !is_lock_btn:
		AudioManager.play("res://Assets/SFX/043 chain hit.wav")
		GameData.tower_store[selected_tower.name].upgrades[upgrade_type] = true
		GameData.mort_flesh -= cost
		


func _on_unlock_button_pressed():
	if selected_tower:
		AudioManager.play("res://Assets/SFX/021 tambo b.wav")
		GameData.mort_flesh -= int(unlock_cost.text)
		GameData.tower_store[selected_tower.name].unlocked = true
	else:
		printerr('No tower selected, this button should not be visible')


func _on_proceed_button_pressed():
	AudioManager.play("res://Assets/SFX/013 JESTER SNARE.wav")
	get_tree().change_scene_to_file("res://BaseGame/base_level.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
