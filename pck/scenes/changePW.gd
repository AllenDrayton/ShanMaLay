extends Control

const profile_textures = []

func _ready():
	_load_profile_textures()


func _load_profile_textures():
	for i in range(26):
		var path = "res://pck/assets/HomeScence/Home-Photo/icon-photo-" + str(i+1) + ".png"
		var texture = load(path)
		profile_textures.append(texture) 


func _on_Exit_pressed():
#	$playerInfoAnimation.play("Out")
	hide()


func _on_Accept_pressed():
	var newPW = $Store_oldpw.text
	var confirmNewPW = $Store_newpw.text
	var data = {
				"username":$"/root/Config".config.user.username,
				"session":$"/root/Config".config.user.session,
				"oldPassword":newPW,
				"newPassword":confirmNewPW
			}
#	print(data)
	var url = $"/root/Config".config.account_url + "password_change"
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_password_changed")
	var headers = ["Content-Type: application/json"]
	var body = JSON.print(data)
	http.request(url,headers,false,HTTPClient.METHOD_POST,body)
	print(body)
	
func _password_changed(result, response_code, headers, body):
	if body.get_string_from_utf8() == "ok":
		$AlertBox._show("Password changed!")
	else:
		$AlertBox._show("Password Do not match!");
