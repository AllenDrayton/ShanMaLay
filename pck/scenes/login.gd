extends Node2D


var filepath = "user://session.txt"
const BlankMusic = preload("res://pck/assets/shankoemee/audio/EmptySound.ogg")
const music = preload("res://pck/assets/audio/music-main-background.mp3")

var bgm_node = Config.MUSIC

# Username and Password
onready var usernameControl = $LoginBox/UsernameControl
onready var username_txt = $LoginBox/UsernameControl/Username
onready var passwordControl = $LoginBox/PasswordControl
onready var password_txt = $LoginBox/PasswordControl/Password
 
var userSide = false
var passwordSide = false


# Called when the node enters the scene tree for the first time.
func _ready():
#	_load_session()
	var savedData = _load()
	if savedData != null:
		$LoginBox/UsernameControl/Username.text = savedData["username"]
		$LoginBox/PasswordControl/Password.text = savedData["password"]
	$version.text = "Version " + str(Config.VERSION)
	_load_bgm()
	Config.MUSIC.stream = music
	Config.MUSIC.play()
	$loginAnimationPlayer.play("Null")
	Signals.connect("screenTouch",self,"_on_screen_touch")

	
	
	# For Keyboard Functions
	usernameControl.connect("mouse_entered", self, "on_userName_entered")
	passwordControl.connect("mouse_entered", self, "on_passWord_entered")
	$CustomKeyboard.connect("enter_pressed", self,"_on_custom_keyboard_enter_pressed")
	$CustomKeyboard.connect("cancel_pressed", self, "_on_custom_keyboard_cancel_pressed")
	show_placeholder()

func _on_MenuMusicOff():
	print("Menu Music Off ok")
	$"/root/bgm".stop()

func musicOn():
	$"/root/bgm".volume_db = 0

func musicOff():
	$"/root/bgm".volume_db = -80

func show_placeholder():
	if username_txt.text == "":
		$LoginBox/UsernameControl/UsernamePlaceholder.show()
	else:
		$LoginBox/UsernameControl/UsernamePlaceholder.hide()
	if password_txt.text == "":
		$LoginBox/PasswordControl/PasswordPlaceholder.show()
	else:
		$LoginBox/PasswordControl/PasswordPlaceholder.hide()

func on_userName_entered():
	on_userName_mouse_entered()
 
func on_passWord_entered():
	on_passWord_mouse_entered()
 
 
func _on_custom_keyboard_enter_pressed(text):
	if userSide:
		username_txt.text = text
	elif passwordSide:
		var hiddenText = ""
		if text != "":
			for i in text.length():
				hiddenText += "*"
				password_txt.text = hiddenText
		else:
			password_txt.text = ""
		$StorePassword.text = text
	$LoginBox/TextureRect.show()
	$LoginBox/UsernameControl.show()
	$LoginBox/TextureRect2.show()
	$LoginBox/PasswordControl.show()
	$AccountButton.show()
	$LoginBox/Login.show()
 
 
func _on_custom_keyboard_cancel_pressed():
	$LoginBox/TextureRect.show()
	$LoginBox/UsernameControl.show()
	$LoginBox/TextureRect2.show()
	$LoginBox/PasswordControl.show()
	$AccountButton.show()
	$LoginBox/Login.show()
 
 
func on_userName_mouse_entered():
	userSide = true
	passwordSide = false
#	yield(get_tree().create_timer(0.8), "timeout")
	$Keyboard_wait_timer.start()
	
 
 
func on_passWord_mouse_entered():
	userSide = false
	passwordSide = true
#	yield(get_tree().create_timer(0.5), "timeout")
	$keyboard_pw_timer.start()


func On():
	if bgm_node:
		bgm_node.volume_db = 0
		
func Off():
	if bgm_node:
		bgm_node.volume_db = -80
	
func _load_bgm():
	if Config.MUSIC == null:
	   var n = load("res://pck/prefabs/bgm.tscn")
	   Config.MUSIC = n.instance()
	   get_tree().root.add_child(Config.MUSIC)

func _on_screen_touch():
	_loginBoxOut()


func _process(delta):
#	print(Config.MUSIC)
	if $LoginBox.visible == true:
		Config.cancel = true
	elif $LoginBox.visible == false:
		Config.cancel = false
#	print(cancel)

	show_placeholder()

func _rejoin_game(gameState) :
	$"/root/ws".rejoin = true
	$"/root/ws".gameState = gameState
	match gameState.game :
		"shankoemee":
			get_tree().change_scene("res://pck/scenes/shankoemee_game.tscn")


func _on_Login_pressed():
	#Config.MUSIC.stream = BlankMusic
	Config.MUSIC.volume_db = -80
	var username = username_txt.text
	var password = $StorePassword.text
	var deviceName = OS.get_model_name()
	var deviceId = OS.get_unique_id()
	
	var regUsername = RegEx.new()
	regUsername.compile("^[0-9a-zA-Z]{4,20}$")
	var resultUsername = regUsername.search(username)
	if !resultUsername :
		$AlertBox._show("Invalid username")
		return
		
	var regPassword = RegEx.new()
	regPassword.compile("^[0-9a-zA-Z]{6,20}$")
	var resultPassword = regPassword.search(password)
#	print(regPassword.search(password))
	if !resultPassword :
		$AlertBox._show("Invalid password")
		return
		
	var data = {
			"username":username,
			"password":password,
			"device":{
				"id":deviceId,
				"name":deviceName
			}
		}	
	var headers = ["Content-Type: application/json"]
	var url = $"/root/Config".config.account_url + "login"
	var body = JSON.print(data)
	$HTTPRequest.request(url,headers,false,HTTPClient.METHOD_POST,body)


func _change_to_menu(username,session,id):
	var user = {"username":username,"session":session,"id":id}
	$"/root/Config".config.user = user
	if $Remember.pressed:
		_save(user)
	get_tree().change_scene("res://pck/scenes/loginLoadingScreen.tscn")


func _load_session():
	var file = File.new()
	if file.file_exists(filepath):
		file.open(filepath, File.READ)
		var txt = file.get_as_text()
		var obj = JSON.parse(txt)
		file.close()
		if obj.error != OK:
			return
		var deviceName = OS.get_model_name()
		var deviceId = OS.get_unique_id()
		var data = {
				"username":obj.result.username,
				"session":obj.result.session,
				"device":{
					"id":deviceId,
					"name":deviceName
					}
				}
		var headers = ["Content-Type: application/json"]
		var url = $"/root/Config".config.account_url + "login"
		var body = JSON.print(data)
		$HTTPRequest.request(url,headers,false,HTTPClient.METHOD_POST,body)

func _save(data):
	var file = File.new()
	file.open(filepath, File.WRITE)
	file.store_string(JSON.print(data))
	file.close()

func _load():
	var file = File.new()
	if file.file_exists(filepath):
		file.open(filepath, File.READ)
		var txt = file.get_as_text()
		file.close()
		var obj = JSON.parse(txt)
		if obj.error == OK:
			return obj.result
	return null

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var respond = JSON.parse(body.get_string_from_utf8()).result
#	print(respond)
	match respond.status:
		"ok":
			if respond.rejoin == true :
				_rejoin_game(respond.gameState)
				return
			if respond.sessionLogin :
				var user = {"username":respond.username,"session":respond.session,"id":respond.id}
				$"/root/Config".config.user = user
				get_tree().change_scene("res://pck/scenes/menu.tscn")
			else :
				_change_to_menu(respond.username,respond.session,respond.id)
		"incorrect username":
			$AlertBox._show("Username number does not exist!")
		"incorrect password":
			$AlertBox._show("Password incorrect " + str(respond.tryCount) + "/10")
		"tmp lock":
			$AlertBox._show("This account is temporary lock. Try again in " + str(respond.body.time) + " minutes")
		"account lock":
			$AlertBox._show("This account is lock!")
		"device lock":
			$AlertBox._show("This device is lock!")

func _loginBoxIn():
	$LoginBox.show()
	$loginAnimationPlayer.play("In")
	
func _loginBoxOut():
	$loginAnimationPlayer.play("Out")

func _on_AccountButton_pressed():
	_loginBoxIn()
	
func _on_Exit_pressed():
	_loginBoxOut()

func _on_loginAnimationPlayer_animation_finished(anim_name):
	if anim_name == "In":
		$AccountButton.set_disabled(true)
	if anim_name == "Out":
		$LoginBox.hide()
		$AccountButton.set_disabled(false)


func _on_Keyboard_wait_timer_timeout():
	$CustomKeyboard/Label.placeholder_text = "Input Username"
 
	if username_txt.text == "":
		$CustomKeyboard/Label.text = ""
	else:
		$CustomKeyboard/Label.text = username_txt.text
	$CustomKeyboard.show()
	$LoginBox/TextureRect.hide()
	$LoginBox/UsernameControl.hide()
	$LoginBox/TextureRect2.hide()
	$LoginBox/PasswordControl.hide()
	$AccountButton.hide()
	$LoginBox/Login.hide()


func _on_keyboard_pw_timer_timeout():
	$CustomKeyboard/Label.placeholder_text = "Input Password"
		
	if password_txt.text == "":
		$CustomKeyboard/Label.text = ""
	else:
		$CustomKeyboard/Label.text = $StorePassword.text
	$CustomKeyboard.show()
	$LoginBox/TextureRect.hide()
	$LoginBox/UsernameControl.hide()
	$LoginBox/TextureRect2.hide()
	$LoginBox/PasswordControl.hide()
	$AccountButton.hide()
	$LoginBox/Login.hide()




func _on_Remember_pressed():
	var username = $LoginBox/UsernameControl/Username.text
	var password = $LoginBox/PasswordControl/Password.text
	
	var data = {
		"username": username,
		"password": password
	}
	_save(data)
