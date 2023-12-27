extends Control

const profile_textures = []
onready var profile = $Profile

var oldPw_side = false
var newPw_side = false



# Called when the node enters the scene tree for the first time.
func _ready():
	_load_profile_textures()
	
	if Signals.user_mute_music == true:
		Config.MUSIC.volume_db = -80
	elif Signals.user_mute_music == false:
		Config.MUSIC.volume_db = 0
	Signals.emit_signal("disableButtons")
	$playerInfoAnimation.play("In")
# warning-ignore:return_value_discarded
	Config.connect("usernameUpdate",self,"_on_usernameUpdate")
	$playerInfoSetting.hide()
	$playerInfoSetting.get_node("playerInfoAnimation").play("RESET")
	profile.rect_scale = Vector2(1.6,1.6)
# warning-ignore:return_value_discarded
	$Exit.connect("pressed", self, "_on_exit")
	
# warning-ignore:return_value_discarded
	$changePW/PWpanel/PwNewControl.connect("mouse_entered", self, "mouse_in_Oldpw")
# warning-ignore:return_value_discarded
	$changePW/PWpanel/ConfirmPwControl.connect("mouse_entered", self, "mouse_in_NewPw")
# warning-ignore:return_value_discarded
	$CustomKeyboard.connect("enter_pressed", self,"_on_custom_keyboard_enter_pressed")
# warning-ignore:return_value_discarded
	$CustomKeyboard.connect("cancel_pressed", self, "_on_custom_keyboard_cancel_pressed")
	show_placeholder()
# warning-ignore:unused_variable
	var request = {
		"head":"user info"
	}
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_update_info")
	http.request(url)
# warning-ignore:unused_variable
	var currentMusic = $"/root/bgm".stream.resource_path.get_file().get_basename()
# warning-ignore:return_value_discarded
	Signals.connect("profileChanged",self,"_on_profile_changed")
	
	

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _update_info(result, response_code, headers, body):
	var respond = JSON.parse(body.get_string_from_utf8()).result
	$Username.text = respond.username
	$Nickname.text = respond.nickname
	$Profile.texture_normal = profile_textures[int(respond.profile) - 1]
	$changePW/PWpanel/Username.text = respond.username

func _on_profile_changed(selected_texture):
	$Profile.texture_normal = selected_texture
	$Profile.texture_normal = selected_texture

# warning-ignore:unused_argument
func _process(delta):
	show_placeholder()


func mouse_in_Oldpw():
	_on_mouse_in_Oldpw()
	
func mouse_in_NewPw():
	_on_mouse_in_Newpw()

func show_placeholder():
	if $changePW/PWpanel/PwNewControl/PasswordNew_txt.text == "":
		$changePW/PWpanel/PwNewControl/PasswordNewPlaceholder.show()
	else:
		$changePW/PWpanel/PwNewControl/PasswordNewPlaceholder.hide()
		
	if $changePW/PWpanel/ConfirmPwControl/ConfirmNewPw_txt.text == "":
		$changePW/PWpanel/ConfirmPwControl/ConfirmNewPlaceholder.show()
	else:
		$changePW/PWpanel/ConfirmPwControl/ConfirmNewPlaceholder.hide()

func _on_custom_keyboard_enter_pressed(text):
	if oldPw_side:
		var hiddenText = ""
		if text != "":
			for i in text.length():
				hiddenText += "*"
				$changePW/PWpanel/PwNewControl/PasswordNew_txt.text = hiddenText
		else:
			$changePW/PWpanel/PwNewControl/PasswordNew_txt.text = ""
		$changePW/Store_oldpw.text = text
	elif newPw_side:
		var hiddenText = ""
		if text != "":
			for i in text.length():
				hiddenText += "*"
				$changePW/PWpanel/ConfirmPwControl/ConfirmNewPw_txt.text = hiddenText
		else:
			 $changePW/PWpanel/ConfirmPwControl/ConfirmNewPw_txt.text = ""
		$changePW/Store_newpw.text = text
	$changePW/PWpanel/PwNewControl.show()
	$changePW/PWpanel/ConfirmPwControl.show()
	$changePW/PWpanel/Accept.show()


func _on_custom_keyboard_cancel_pressed():
	$changePW/PWpanel/PwNewControl.show()
	$changePW/PWpanel/ConfirmPwControl.show()
	$changePW/PWpanel/Accept.show()

func _on_mouse_in_Oldpw():
	oldPw_side = true
	newPw_side = false
	$OldPw_timer.start()


func _on_mouse_in_Newpw():
	oldPw_side = false
	newPw_side = true
	$NewPw_timer.start()

func _on_usernameUpdate(name):
	$Nickname.text = name

func _load_profile_textures():
	for i in range(26):
		var path = "res://pck/assets/HomeScence/Home-Photo/icon-photo-" + str(i+1) + ".png"
		var texture = load(path)
		profile_textures.append(texture) 

func _on_exit():
	hide()
	$playerInfoAnimation.play("Out")

func _on_Profile_pressed():
	$playerInfoSetting.show()
	$playerInfoSetting/playerInfoAnimation.play("In")


func _on_Edit_pressed():
	$changeUsername.show()


func _on_PW_Change_pressed():
	$changePW.show()


func _on_OldPw_timer_timeout():
	$CustomKeyboard/Label.placeholder_text = "Input Old Password"
 
	if $changePW/PWpanel/PwNewControl/PasswordNew_txt.text == "":
		$CustomKeyboard/Label.text = ""
	else:
		$CustomKeyboard/Label.text = $changePW/Store_oldpw.text
	$CustomKeyboard.show()
	$changePW/PWpanel/PwNewControl.hide()
	$changePW/PWpanel/ConfirmPwControl.hide()
	$changePW/PWpanel/Accept.hide()


func _on_NewPw_timer_timeout():
	$CustomKeyboard/Label.placeholder_text = "Input New Password"
		
	if$changePW/PWpanel/ConfirmPwControl/ConfirmNewPw_txt.text == "":
		$CustomKeyboard/Label.text = ""
	else:
		$CustomKeyboard/Label.text = $changePW/Store_newpw.text
	$CustomKeyboard.show()
	$changePW/PWpanel/PwNewControl.hide()
	$changePW/PWpanel/ConfirmPwControl.hide()
	$changePW/PWpanel/Accept.hide()


func _on_Exit_pressed():
	Config.MUSIC.volume_db = -80
	$playerInfoAnimation.play("Out")


func _on_playerInfoAnimation_animation_finished(anim_name):
	if anim_name == "Out":
		LoadingScript.load_scene(self, "res://pck/scenes/menu.tscn")
