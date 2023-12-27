extends Control

func _ready():
	$transferAnimation.play("In")
	Config.MUSIC.volume_db = 0
	var request = {
		"head":"user info"
	}
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_update_info")
	http.request(url)
	
	if Signals.user_mute_music == true:
		Config.MUSIC.volume_db = -80
	elif Signals.user_mute_music == false:
		Config.MUSIC.volume_db = 0
	
func _update_info(result, response_code, headers, body):
	var respond = JSON.parse(body.get_string_from_utf8()).result
	print(respond)
	$transferPanel/Balance.text = comma_sep(respond.balance)
	
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
