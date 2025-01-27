extends Control


func _draw():
	var range = get_parent().tower_stats.calculated_range
	draw_circle(Vector2(0,0), range, Color.WHITE)
