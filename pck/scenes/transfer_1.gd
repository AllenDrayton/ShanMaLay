extends Control

func _ready():
	$transferAnimation.play("In")
	Config.MUSIC.volume_db = 0
	
	if Signals.user_mute_music == true:
		Config.MUSIC.volume_db = -80
	elif Signals.user_mute_music == false:
		Config.MUSIC.volume_db = 0
	
func comma_sep(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]

	return res

func _on_Exit_pressed():
	$transferAnimation.play("Out")
	Config.MUSIC.volume_db = -80
	
	
func _on_transfer_pressed():
	$transfer_history.show()

func _on_transferAnimation_animation_finished(anim_name):
	if anim_name == "Out":
		LoadingScript.load_scene(self, "res://pck/scenes/menu.tscn")
