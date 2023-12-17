extends Node2D

#const music = preload("res://pck/assets/shankoemee/audio/EmptySound.ogg")
export (float) var time = 0.5

func _ready():
	$AnimationPlayer.play("New Anim")
	$Timer.wait_time = time
	$Timer.start()
#	Config.MUSIC.stream = music
#	Config.MUSIC.play()
#	Config.MUSIC.volume_db = 0


func _on_Timer_timeout():
	get_tree().change_scene("res://pck/scenes/menu.tscn")
