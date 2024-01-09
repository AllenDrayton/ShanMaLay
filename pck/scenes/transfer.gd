extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Exit_pressed():
	get_tree().change_scene("res://pck/scenes/menu.tscn")


func _on_transfer_pressed():
	get_tree().change_scene("res://pck/scenes/transfer_history.tscn")
