extends AnimatedSprite

func _ready():
	frame = 0
	play("in")
	$splash.hide()
	$AudioStreamPlayer.play()


func _on_splashScene_animation_finished():
	frame = 0
	$splash.play("splash")
	$splash.show()


func _on_splash_animation_finished():
	get_tree().change_scene("res://pck/scenes/login.tscn")
