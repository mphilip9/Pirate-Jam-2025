extends Node2D


func _draw():
	var range = get_parent().eye_tower_stats.range
	print(range)
	draw_circle(Vector2(0,0), range, Color.WHITE)
