extends Control


func _draw():
	var range = get_parent().tower_stats.range
	print(range)
	draw_circle(Vector2(0,0), range, Color.WHITE)
