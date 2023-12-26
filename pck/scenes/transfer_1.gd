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
#	hide()
	$transferAnimation.play("Out")
	Config.MUSIC.volume_db = -80
	get_tree().change_scene("res://pck/prefabs/loadingScreen.tscn")
	
func _on_transfer_pressed():
	$transfer_history.show()
#	get_tree().change_scene("res://pck/scenes/transfer_history.tscn")
