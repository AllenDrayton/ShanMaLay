extends Control

func _ready():
	$withdrawAnimation.play("In")
	Config.MUSIC.volume_db = 0
# warning-ignore:unused_variable
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
	
# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _update_info(result, response_code, headers, body):
	var respond = JSON.parse(body.get_string_from_utf8()).result
	print(respond)
	$Withdraw_panel/Balance1.text = comma_sep(respond.balance)
	$Withdraw_panel/Balance2.text = comma_sep(respond.balance)
	
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
	$withdrawAnimation.play("Out")
# warning-ignore:return_value_discarded


func _on_TextureButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://pck/scenes/Bank_info.tscn")


func _on_withdraw2_pressed():
	Config.MUSIC.volume_db = -80
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://pck/scenes/transfer_history.tscn")


func _on_withdrawAnimation_animation_finished(anim_name):
	if anim_name == "Out":
		LoadingScript.load_scene(self, "res://pck/scenes/menu.tscn")
