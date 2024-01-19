extends Area2D


func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		print("OK")
#		get_parent().get_parent().get_node("EmojiHomePanel").hide()
