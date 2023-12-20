extends Control

const profile_textures = []
onready var profile = $Profile

var oldPw_side = false
var newPw_side = false



# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	Config.connect("usernameUpdate",self,"_on_usernameUpdate")
	$playerInfoSetting.hide()
	$playerInfoAnimation.play("RESET")
	$playerInfoSetting.get_node("playerInfoAnimation").play("RESET")
#	$playerInfoAnimation.play("In")
	profile.rect_scale = Vector2(1.6,1.6)
	$Exit.connect("pressed", self, "_on_exit")
	
	$changePW/PWpanel/PwNewControl.connect("mouse_entered", self, "mouse_in_Oldpw")
	$changePW/PWpanel/ConfirmPwControl.connect("mouse_entered", self, "mouse_in_NewPw")
	$CustomKeyboard.connect("enter_pressed", self,"_on_custom_keyboard_enter_pressed")
	$CustomKeyboard.connect("cancel_pressed", self, "_on_custom_keyboard_cancel_pressed")
	show_placeholder()
	

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
		var path = "res://pck/assets/common/profiles/" + str(i) + ".png"
		var texture = load(path)
		profile_textures.append(texture) 

func _on_exit():
	hide()
	$playerInfoAnimation.play("Out")

func _on_Profile_pressed():
	$playerInfoSetting.show()
	$playerInfoSetting.get_node("playerInfoAnimation").play("In")


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
