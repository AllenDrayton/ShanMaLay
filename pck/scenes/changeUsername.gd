extends Control

onready var tick = load("res://pck/assets/HomeScence/Home-Change-Username/icon-change-username-checked.png")

func _ready():

# warning-ignore:return_value_discarded
	$Male.connect("pressed",self,"_on_male_pressed")
	$Male.texture_normal = null
# warning-ignore:return_value_discarded
	$Female.connect("pressed",self,"_on_female_pressed")
	$Female.texture_normal = null
# warning-ignore:unused_variable
	var request = {
		"head":"user info"
	}
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_update_info")
	http.request(url)

func _on_affirmative_pressed():
	var username = $usernamePanel/Username.text
	var data = {
		"username":$"/root/Config".config.user.username,
		"session":$"/root/Config".config.user.session,
		"nickname":username
		}
	var url = $"/root/Config".config.account_url + "nickname_change"
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_nickname_changed")
	var headers = ["Content-Type: application/json"]
	var body = JSON.print(data)
	http.request(url,headers,false,HTTPClient.METHOD_POST,body)
	var name = data["nickname"]
	Config.emit_signal("usernameUpdate",name)
	hide()

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _update_info(result, response_code, headers, body):
# warning-ignore:unused_variable
	var respond = JSON.parse(body.get_string_from_utf8()).result
#	$usernamePanel/NameTag2.text = respond.nickname
#	print(respond.nickname)

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _nickname_changed(result, response_code, headers, body):
	pass
#	if body.get_string_from_utf8() == "ok":
#		$AlertBox._show("Nickname changed!")

func _on_male_pressed():
	print("male pressed!")
	$Male.texture_normal = tick
	$Female.texture_normal = null
	
	
func _on_female_pressed():
	print("female pressed!")
	$Female.texture_normal = tick
	$Male.texture_normal = null

func _on_cancel_pressed():
	hide()
	
func _on_Exit_pressed():
	hide()


