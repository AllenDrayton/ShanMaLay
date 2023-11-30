extends Area2D

#var cancel = get_parent().cancel

func _input(event):
	if event is InputEventScreenDrag and get_parent().cancel == true:
		pass
