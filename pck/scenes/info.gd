extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Config.MUSIC.volume_db = 0
	$InfoAnimation.play("In")

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
	Config.MUSIC.volume_db = -80
	$InfoAnimation.play("Out")
	

func _on_bank_info_pressed():
	$bank_info.show()


func _on_InfoAnimation_animation_finished(anim_name):
	if anim_name == "Out":
		LoadingScript.load_scene(self, "res://pck/scenes/menu.tscn")
