extends PanelContainer

var selected_tower: String


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("tower_store_buttons"):
		if button.has_signal("store_button_pressed"):
			print('here?')
			button.store_button_pressed.connect(self._on_store_button_pressed)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_store_button_pressed(data):
	print('whoah', data)
