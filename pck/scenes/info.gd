extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Config.MUSIC.volume_db = 0
	$InfoAnimation.play("In")
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
	$info_panel/Balance.text = comma_sep(respond.balance)
	
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
	get_tree().change_scene("res://pck/prefabs/loadingScreen.tscn")

func _on_bank_info_pressed():
	$bank_info.show()
