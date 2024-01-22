extends Node2D


const profile_textures = []
var filepath = "user://session.txt"

var http

onready var nickname_control = $NicknamePanel/NicknameControl
onready var old_pw_control = $PasswordPanel/OldPwControl
onready var new_pw_control = $PasswordPanel/NewPwControl

onready var nickname_txt = $NicknamePanel/NicknameControl/Label
onready var old_pw_txt = $PasswordPanel/OldPwControl/OldPw
onready var new_pw_txt = $PasswordPanel/NewPwControl/NewPw

var userSide = false
var oldpasswordside = false
var newpasswordside = false

var username_entered = false
var old_password_entered = false
var new_password_entered = false


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Reset The Music
	#$"/root/bgm".volume_db = $Setting/SliderMusic.value
	
	if $Setting/SliderMusic.value == 0:
		$"/root/bgm".volume_db =  $Setting/SliderMusic.value
	else:
		$"/root/bgm".volume_db += 45
	
	_load_profile_textures()
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	http = HTTPRequest.new()
	add_child(http)
	http.timeout = 3
	http.connect("request_completed",self,"_update_info")
	http.request(url)

#	nickname_control.connect("mouse_entered", self, "on_userName_entered")
#	old_pw_control.connect("mouse_entered", self, "on_old_passWord_entered")
#	new_pw_control.connect("mouse_entered", self, "on_new_passWord_entered")
	nickname_control.connect("mouse_entered", self, "on_userName_mouse_entered")
	old_pw_control.connect("mouse_entered", self, "on_OldpassWord_mouse_entered")
	new_pw_control.connect("mouse_entered", self, "on_NewpassWord_mouse_entered")
	$CustomKeyboard.connect("enter_pressed", self,"_on_custom_keyboard_enter_pressed")
	$CustomKeyboard.connect("cancel_pressed", self, "_on_custom_keyboard_cancel_pressed")
#	$NicknamePanel/ChangeNickname.connect("mouse_entered", self, "change_nickname_entered")
#	$PasswordPanel/ChangePassword.connect("mouse_entered", self, "change_password_entered")
#	$Logout.connect("mouse_entered", self, "change_account_entered")
	
	label_placeholder()


func _process(delta):
	label_placeholder()
	

func label_placeholder():
	if nickname_txt.text == "":
		nickname_txt.text = "Username"
	else:
		pass
		
	if old_pw_txt.text == "":
		old_pw_txt.text = "Old Password"
	else:
		pass
	
	if new_pw_txt.text == "":
		new_pw_txt.text = "New Password"
	else:
		pass

#func on_userName_entered():
#	var username_entered = true
#	var old_password_entered = false
#	var new_password_entered = false
#
#func on_old_passWord_entered():
#	var username_entered = false
#	var old_password_entered = true
#	var new_password_entered = false
#
#func on_new_passWord_entered():
#	var username_entered = false
#	var old_password_entered = false
#	var new_password_entered = true
#
#func change_nickname_entered():
#	var username_entered = false
#	var old_password_entered = false
#	var new_password_entered = false
#
#func change_password_entered():
#	var username_entered = false
#	var old_password_entered = false
#	var new_password_entered = false
#
#
#func change_account_entered():
#	var username_entered = false
#	var old_password_entered = false
#	var new_password_entered = false


func _on_custom_keyboard_enter_pressed(text):
	if userSide:
		nickname_txt.text = text
	elif oldpasswordside:
		var hiddenText = ""
		if text != "":
			for i in text.length():
				hiddenText += "*"
				old_pw_txt.text = hiddenText
		else:
			old_pw_txt.text = ""
		$StoreOldpw.text = text
	elif newpasswordside:
		var hiddenText = ""
		if text != "":
			for i in text.length():
				hiddenText += "*"
				new_pw_txt.text = hiddenText
		else:
			new_pw_txt.text = ""
		$StoreNewpw.text = text
	nickname_control.show()
	old_pw_control.show()
	new_pw_control.show()
	$NicknamePanel/ChangeNickname.show()
	$PasswordPanel/ChangePassword.show()
	$Logout.show()
	username_entered = false
	old_password_entered = false
	new_password_entered = false


func _on_custom_keyboard_cancel_pressed():
	nickname_control.show()
	old_pw_control.show()
	new_pw_control.show()
	$NicknamePanel/ChangeNickname.show()
	$PasswordPanel/ChangePassword.show()
	$Logout.show()
	username_entered = false
	old_password_entered = false
	new_password_entered = false


func on_userName_mouse_entered():
	userSide = true
	oldpasswordside = false
	newpasswordside = false
	yield(get_tree().create_timer(0.8), "timeout")
	$CustomKeyboard/Label.placeholder_text = "Username"

	if nickname_txt.text == "Username":
		$CustomKeyboard/Label.text = ""
	else:
		$CustomKeyboard/Label.text = nickname_txt.text
	$CustomKeyboard.show()
	nickname_control.hide()
	old_pw_control.hide()
	new_pw_control.hide()
	$NicknamePanel/ChangeNickname.hide()
	$PasswordPanel/ChangePassword.hide()
	$Logout.hide()
	username_entered = false
	old_password_entered = false
	new_password_entered = false
	
func on_OldpassWord_mouse_entered():
	userSide = false
	oldpasswordside = true
	newpasswordside = false
	yield(get_tree().create_timer(0.8), "timeout")
	$CustomKeyboard/Label.placeholder_text = "Old Password"

	if old_pw_txt.text == "Old Password":
		$CustomKeyboard/Label.text = ""
	else:
		$CustomKeyboard/Label.text = $StoreOldpw.text
	$CustomKeyboard.show()
	nickname_control.hide()
	old_pw_control.hide()
	new_pw_control.hide()
	$NicknamePanel/ChangeNickname.hide()
	$PasswordPanel/ChangePassword.hide()
	$Logout.hide()
	username_entered = false
	old_password_entered = false
	new_password_entered = false


func on_NewpassWord_mouse_entered():
	userSide = false
	oldpasswordside = false
	newpasswordside = true
	yield(get_tree().create_timer(0.8), "timeout")
	$CustomKeyboard/Label.placeholder_text = "New Password"

	if new_pw_txt.text == "New Password":
		$CustomKeyboard/Label.text = ""
	else:
		$CustomKeyboard/Label.text = $StoreNewpw.text
	$CustomKeyboard.show()
	nickname_control.hide()
	old_pw_control.hide()
	new_pw_control.hide()
	username_entered = false
	old_password_entered = false
	new_password_entered = false

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and username_entered:
		on_userName_mouse_entered()
	elif event is InputEventMouseButton and event.is_pressed() and old_password_entered:
		on_OldpassWord_mouse_entered()
	elif event is InputEventMouseButton and event.is_pressed() and new_password_entered:
		on_NewpassWord_mouse_entered()


func _update_info(result, response_code, headers, body):
	if response_code != 200:
		$"/root/bgm".volume_db = -50
		LoadingScript.load_scene(self, "res://start/conn_error.tscn")
	else:
		var respond = JSON.parse(body.get_string_from_utf8()).result
		nickname_txt.text = respond.nickname
		$ProfilePanel/Profile.texture = profile_textures[int(respond.profile)]


func _load_profile_textures():
	for i in range(13):
		var path = "res://pck/assets/common/profiles/" + str(i) + ".png"
		var texture = load(path)
		profile_textures.append(texture) 


func _on_profile_select(index):
	$ProfilePanel/Profile.texture = profile_textures[index]
	var data = {
		"username":$"/root/Config".config.user.username,
		"session":$"/root/Config".config.user.session,
		"index":index
	}
	var url = $"/root/Config".config.account_url + "profile_change"
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_profile_changed")
	var headers = ["Content-Type: application/json"]
	var body = JSON.print(data)
	http.request(url,headers,false,HTTPClient.METHOD_POST,body)


func _profile_changed(result, response_code, headers, body):
	if body.get_string_from_utf8() == "ok":
		$AlertBox._show("Profile image changed!")


func _on_Exit_pressed():
	
	# For Music
	$"/root/bgm".volume_db = -50
	
	#get_tree().change_scene("res://pck/scenes/menu.tscn")
	LoadingScript.load_scene(self, "res://pck/scenes/menu.tscn")


func _on_ChangeNickname_pressed():
	var nickname = nickname_txt.text
	var data = {
		"username":$"/root/Config".config.user.username,
		"session":$"/root/Config".config.user.session,
		"nickname":nickname
	}
	var url = $"/root/Config".config.account_url + "nickname_change"
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_nickname_changed")
	var headers = ["Content-Type: application/json"]
	var body = JSON.print(data)
	http.request(url,headers,false,HTTPClient.METHOD_POST,body)


func _nickname_changed(result, response_code, headers, body):
	if body.get_string_from_utf8() == "ok":
		$AlertBox._show("Nickname changed!")


func _on_ChangePassword_pressed():
	var oldPassword = $StoreOldpw.text
	var newPassword = $StoreNewpw.text
	var data = {
			"username":$"/root/Config".config.user.username,
			"session":$"/root/Config".config.user.session,
			"oldPassword":oldPassword,
			"newPassword":newPassword
		}
	var url = $"/root/Config".config.account_url + "password_change"
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_password_changed")
	var headers = ["Content-Type: application/json"]
	var body = JSON.print(data)
	http.request(url,headers,false,HTTPClient.METHOD_POST,body)


func _password_changed(result, response_code, headers, body):
	if body.get_string_from_utf8() == "ok":
		$AlertBox._show("Password changed!")
	else:
		$AlertBox._show("Old password incorrect!");


func _on_Logout_pressed():
	
	# For Music
	$"/root/bgm".volume_db = -50
	
	var file = File.new()
	file.open(filepath, File.WRITE)
	file.store_string("")
	file.close()
	
	Config.logout = true
	
	#get_tree().change_scene("res://pck/scenes/login.tscn")
	LoadingScript.load_scene(self, "res://pck/scenes/login.tscn")
