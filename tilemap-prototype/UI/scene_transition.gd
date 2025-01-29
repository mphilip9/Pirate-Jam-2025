extends Control
@onready var animation_player = $AnimationPlayer
@onready var color_rect = $ColorRect


func _ready():
#	Setting the color to black so on load it doesn't jitter as it plats the animation
	color_rect.color.a = 255
	animation_player.play('fade_in')

func change_scene(target: String) -> void:
	animation_player.play("fade_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target)
