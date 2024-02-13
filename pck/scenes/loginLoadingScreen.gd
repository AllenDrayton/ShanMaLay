extends Node2D

export (float) var time = 0.5

func _ready():
	$AnimationPlayer.play("New Anim")
	$Timer.wait_time = time
	$Timer.start()
	

func _on_Timer_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://pck/scenes/menu.tscn")
