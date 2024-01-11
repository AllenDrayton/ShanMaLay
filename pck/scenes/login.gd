extends Node2D

const music = preload("res://pck/assets/audio/music-1.mp3")

var filepath = "user://session.txt"

onready var userName = $Control
onready var passWord = $Control2


var userSide = false
var passwordSide = false

var username_entered = false
var password_entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	process_whole_url()
	
	_load_session()
	_load_bgm()
	
	if $Setting/SliderMusic.value == 0:
		$"/root/bgm".volume_db =  $Setting/SliderMusic.value
	else:
		$"/root/bgm".volume_db += 45
	
	
	userName.connect("mouse_entered", self, "on_userName_mouse_entered")
	passWord.connect("mouse_entered", self, "on_passWord_mouse_entered")
#	userName.connect("mouse_entered", self, "on_userName_entered")
#	passWord.connect("mouse_entered", self, "on_passWord_entered")
#	$Remember.connect("mouse_entered", self, "on_remember_entered")
	$CustomKeyboard.connect("enter_pressed", self,"_on_custom_keyboard_enter_pressed")
	$CustomKeyboard.connect("cancel_pressed", self, "_on_custom_keyboard_cancel_pressed")
	
	label_placeholder()
	
	var currentMusic = $"/root/bgm".stream.resource_path.get_file().get_basename()
	if currentMusic != "music-1":
		$"/root/bgm".stream = music
		$"/root/bgm".play()

func _process(delta):
	label_placeholder()


#func _input(event):
#	if event is InputEventMouseButton and event.is_pressed() and username_entered:
#		on_userName_mouse_entered()
#	elif event is InputEventMouseButton and event.is_pressed() and password_entered:
#		on_passWord_mouse_entered()


#func on_userName_entered():
#	username_entered = true
#	password_entered = false
#
#func on_passWord_entered():
#	username_entered = false
#	password_entered = true
#
#func on_remember_entered():
#	username_entered = false
#	password_entered = false

func label_placeholder():
	if $Control/Username.text == "":
		$Control/Username.text = "Username"
	else:
		pass
		
	if $Control2/Password.text == "":
		$Control2/Password.text = "Password"
	else:
		pass


func _on_custom_keyboard_enter_pressed(text):
	if userSide:
		$Control/Username.text = text
	elif passwordSide:
		var hiddenText = ""
		if text != "":
			for i in text.length():
				hiddenText += "*"
				$Control2/Password.text = hiddenText
		else:
			$Control2/Password.text = ""
		$Store.text = text
	userName.show()
	passWord.show()
	$Login.show()
	$Remember.disabled = false
	username_entered = false
	password_entered = false


func _on_custom_keyboard_cancel_pressed():
	userName.show()
	passWord.show()
	$Login.show()
	$Remember.disabled = false
	username_entered = false
	password_entered = false


func on_userName_mouse_entered():
	userSide = true
	passwordSide = false
	yield(get_tree().create_timer(0.5), "timeout")
	$CustomKeyboard/Label.placeholder_text = "Username"

	if $Control/Username.text == "Username":
		$CustomKeyboard/Label.text = ""
	else:
		$CustomKeyboard/Label.text = $Control/Username.text
	$CustomKeyboard.show()
	userName.hide()
	passWord.hide()
	$Login.hide()
	$Remember.disabled = true
	username_entered = false
	password_entered = false

func on_passWord_mouse_entered():
	userSide = false
	passwordSide = true
	yield(get_tree().create_timer(0.5), "timeout")
	$CustomKeyboard/Label.placeholder_text = "Password"

	if $Control2/Password.text == "Password":
		$CustomKeyboard/Label.text = ""
	else:
		$CustomKeyboard/Label.text = $Store.text
	$CustomKeyboard.show()
	userName.hide()
	passWord.hide()
	$Login.hide()
	$Remember.disabled = true
	username_entered = false
	password_entered = false


func _load_bgm():
	var bgm = get_tree().root.get_node_or_null("bgm")
	if !bgm:
		var n = load("res://pck/prefabs/bgm.tscn")
		get_tree().root.add_child(n.instance())


func _rejoin_game(gameState) :
	$"/root/ws".rejoin = true
	$"/root/ws".gameState = gameState
	match gameState.game :
		"shankoemee":
			get_tree().change_scene("res://pck/scenes/shankoemee_game.tscn")


func _on_Login_pressed():
	
	# For Music
	$"/root/bgm".volume_db = -50
	
	var username = $Control/Username.text
	var password = $Store.text
	print("Username : ", username)
	print("Password : ", password)
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
	$HTTPRequest.timeout = 3
	$HTTPRequest.request(url,headers,false,HTTPClient.METHOD_POST,body)


func _change_to_menu(username,session,id):
	var user = {"username":username,"session":session,"id":id}
	$"/root/Config".config.user = user
	if $Remember.pressed :
		_save(user)
	#get_tree().change_scene("res://pck/scenes/menu.tscn")
	LoadingScript.load_scene(self, "res://pck/scenes/menu.tscn")


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
	print("This is Login Response Code : ", response_code)
	if response_code != 200:
		$"/root/bgm".volume_db = -50
		LoadingScript.load_scene(self, "res://start/conn_error.tscn")
	else:
		match respond.status:
			"ok":
				if respond.rejoin == true :
					_rejoin_game(respond.gameState)
					return
				if respond.sessionLogin :
					var user = {"username":respond.username,"session":respond.session,"id":respond.id}
					$"/root/Config".config.user = user
					#get_tree().change_scene("res://pck/scenes/menu.tscn")
					$"/root/bgm".volume_db = -50
					LoadingScript.load_scene(self, "res://pck/scenes/menu.tscn")
				else :
					$"/root/bgm".volume_db = -50
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
				
# Function to get the whole URL
func get_whole_url():
	if OS.has_feature('JavaScript'):
		return JavaScript.eval("""
			window.location.href;
		""")
	return ""

func extract_unique_id_from_url(whole_url):
	var query_start = whole_url.find("?")  # Find the position of the '?' character
	if query_start >= 0:
		var parameters = whole_url.substr(query_start+1)  # Extract substring starting from '?'
		return parameters
	else:
		return ""

# Function to use the whole URL
func process_whole_url():
	var whole_url = get_whole_url()
#	var whole_url = "https://example.com/?123456789"
	var uniqueid = extract_unique_id_from_url(whole_url)
	if uniqueid != "":
		print("Extracted unique ID: ",uniqueid)
		Config.UNIQUE = uniqueid
