extends Node2D


var filepath = "user://session.txt"
var bgm_node = null

# Called when the node enters the scene tree for the first time.
func _ready():
#	_load_session()
	_load_bgm()
	$loginAnimationPlayer.play("Null")
	Signals.connect("screenTouch",self,"_on_screen_touch")
	Config.connect("musicOff",self,"Off")
	Config.connect("musicOn",self,"On")
	
	
func On():
	if bgm_node:
		bgm_node.volume_db = 0
		
func Off():
	if bgm_node:
		bgm_node.volume_db = -80
	
func _load_bgm():
	if bgm_node == null:
	   var n = load("res://pck/prefabs/bgm.tscn")
	   bgm_node = n.instance()
	   get_tree().root.add_child(bgm_node)

func _on_screen_touch():
	_loginBoxOut()



func _process(delta):
	if $LoginBox.visible == true:
		Config.cancel = true
	elif $LoginBox.visible == false:
		Config.cancel = false
#	print(cancel)

func _rejoin_game(gameState) :
	$"/root/ws".rejoin = true
	$"/root/ws".gameState = gameState
	match gameState.game :
		"shankoemee":
			get_tree().change_scene("res://pck/scenes/shankoemee_game.tscn")


func _on_Login_pressed():
	var username = $LoginBox/Username.text
	var password = $LoginBox/Password.text
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
	if $Remember.pressed :
		_save(user)
	get_tree().change_scene("res://pck/scenes/menu.tscn")


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
