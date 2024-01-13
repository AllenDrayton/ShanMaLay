extends AnimatedSprite

func _ready():
	$Door.play("idle")


func _on_splashScene_animation_finished():
	$splash.frame = 0
	$splash.play("splash")
	$splash.show()


func _on_splash_animation_finished():
	$AudioStreamPlayer.volume_db = -80
	#get_tree().change_scene("res://pck/scenes/login.tscn")
	LoadingScript.load_scene(self, "res://pck/scenes/login.tscn")


func _on_openButton_pressed():
	$openAnimation.play("out")
	$AudioStreamPlayer.volume_db = 0
	$AudioStreamPlayer.play()


func _on_openAnimation_animation_finished(anim_name):
	$Door.hide()
	frame = 0
	play("in")
	$splash.hide()
	
