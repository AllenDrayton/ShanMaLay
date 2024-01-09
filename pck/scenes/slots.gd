extends Node2D

var slot_1_textures = []
var slot_2_textures = []

var balance
var isExit = false
var url

var websocket_url = "ws://redboxmm.tech:8081/acrf-qarava-slot/slotplaysocket"
#var websocket_url = "wss://libwebsockets.org"
var websocket = WebSocketClient.new()


var arrows = {
	"glow": preload("res://pck/assets/slots/ARROW 2.png"),
	"dull": preload("res://pck/assets/slots/ARROW 1.png")
}



func _ready():
	_connect_ws()
	$Left.disabled = true
	$Left.texture_disabled = arrows["dull"]
	$Left.modulate = Color(.7,.7,.7,.85)
	_loadTextures()
	
	if Signals.user_mute_music == true:
		Config.MUSIC.volume_db = -80
	elif Signals.user_mute_music == false:
		Config.MUSIC.volume_db = 0
	
# warning-ignore:shadowed_variable
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	
	http.connect("request_completed",self,"_update_info")
	http.request(url)
	
# warning-ignore:unused_argument
func _process(delta):
	websocket.poll()
# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _update_info(result, response_code, headers, body):
	var respond = JSON.parse(body.get_string_from_utf8()).result
	balance = respond.balance
	$Balance.text = comma_sep(respond.balance)
	

func comma_sep(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]
	return res




func _loadTextures():
	for i in range(10):
		var path = "res://pck/assets/slots/assets/B" + str(i+1) + ".png"
		var texture = load(path)
		slot_1_textures.append(texture)
	for ii in range(10,20):
		var path = "res://pck/assets/slots/assets/B" + str(ii+1) + ".png"
		var texture = load(path)
		slot_2_textures.append(texture)
	var slot1 = $slotContainer_1/slotProviderContainer.get_children()
	for j in range(slot1.size()):
		var slot = slot1[j]
		if slot is TextureButton:
			slot.texture_normal = slot_1_textures[j]
	var slot2 = $slotContainer_2/slotProviderContainer.get_children()
	for k in range(slot2.size()):
		var slot = slot2[k]
		if slot is TextureButton:
			slot.texture_normal = slot_2_textures[k]


func _clear():
	$slotContainer_1.hide()
	$slotContainer_2.hide()
	$"Icon-bottom-bar".hide()
	$Balance.hide()
	$Balance_Boarder.hide()
	$Back.hide()
	$Slots.hide()



func _connect_ws():
	websocket.connect("connection_established", self, "_on_connected")
	websocket.connect("data_received", self, "_on_data")
	websocket.connect("connection_closed", self, "_closed")
	websocket.connect("connection_error", self, "_error_closed")

	var err = websocket.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)
	else:
		print("... Connecting")
		pass

func on_balance_request_completed(result, response_code, headers, body):
	var json_result = JSON.parse(body.get_string_from_utf8()).result
	$Balance.text = comma_sep(json_result["balance"])


func balance_update():
	var http = HTTPRequest.new()
	var url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotuserconnect/getuserbalance/"+$"/root/Config".config.user.username
	add_child(http)
	http.connect("request_completed",self,"on_balance_request_completed")
	http.request(url)

func _send_data(data):
	var json = JSON.print(data)
	print(json)
	var peer = websocket.get_peer(1)
	peer.set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)

	var data_utf8 = json.to_utf8()
	var success = peer.put_packet(data_utf8)

	if success != OK:
		print("Failed to send data.")
	else:
		print("")

func disable_buttons(disable):
	for i in $slotContainer_1/slotProviderContainer.get_children():
		i.disabled = disable
	for j in $slotContainer_2/slotProviderContainer.get_children():
		j.disabled = disable

func _on_data():
	var message = websocket.get_peer(1).get_packet().get_string_from_utf8()
	print("Received data from Server:", message)
	var obj = JSON.parse(message)
	var res = obj.result
	print("--- Respond for First ---")
	
	# Handling different states
	match res.stateForFirst:
		"STATE_CONNECT":
			print("CLIENT CONNECTED")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("connected")
				"STATE_READY":
					$loadingScreen.hide()
					disable_buttons(false)
				"STATE_PLAY":
					$loadingScreen.show()
					disable_buttons(true)
				"STATE_DISCONNECT":
					print("Disconnected")
				"STATE_EXIT":
					LoadingScript.load_scene(self,"res://pck/scenes/menu.tscn")
		"STATE_READY":
			print("READY TO GO TO SLOTTTTTTTTTTTTTTTTTTT!!!!")
			balance_update()
			match res.stateForSecond:
				"STATE_CONNECT":
					print("connected")
				"STATE_READY":
					$loadingScreen.hide()
					disable_buttons(false)
				"STATE_PLAY":
					$loadingScreen.show()
					disable_buttons(true)
				"STATE_DISCONNECT":
					print("Disconnected")
				"STATE_EXIT":
					LoadingScript.load_scene(self,"res://pck/scenes/menu.tscn")
		"STATE_PLAY":
			print("READY TO PLAY")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("connected")
				"STATE_READY":
					$loadingScreen.hide()
					disable_buttons(false)
				"STATE_PLAY":
					$loadingScreen.show()
					disable_buttons(true)
				"STATE_DISCONNECT":
					print("Disconnected")
				"STATE_EXIT":
					LoadingScript.load_scene(self,"res://pck/scenes/menu.tscn")
		"STATE_DISCONNECT":
			print("Disconnected")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("connected")
				"STATE_READY":
					$loadingScreen.hide()
					disable_buttons(false)
				"STATE_PLAY":
					$loadingScreen.show()
					disable_buttons(true)
				"STATE_DISCONNECT":
					print("Disconnected")
				"STATE_EXIT":
					LoadingScript.load_scene(self,"res://pck/scenes/menu.tscn")
		"STATE_EXIT":
			match res.stateForSecond:
				"STATE_CONNECT":
					print("connected")
				"STATE_READY":
					$loadingScreen.hide()
					disable_buttons(false)
				"STATE_PLAY":
					$loadingScreen.show()
					disable_buttons(true)
				"STATE_DISCONNECT":
					print("Disconnected")
				"STATE_EXIT":
					LoadingScript.load_scene(self,"res://pck/scenes/menu.tscn")
		"":
			match res.stateForSecond:
				"STATE_CONNECT":
					print("connected")
				"STATE_READY":
					print("READY TO GO TO SLOTTTTTTTTTTTTTTTTTTT!!!!")
					$loadingScreen.hide()
					disable_buttons(false)
				"STATE_PLAY":
					$loadingScreen.show()
					disable_buttons(true)
				"STATE_DISCONNECT":
					print("Disconnected")
				"STATE_EXIT":
					LoadingScript.load_scene(self,"res://pck/scenes/menu.tscn")

func _on_connected(proto = ""):
	# Send message to the WebSocket based on the stateForSecond
	print("Connection_Successful with Protocol : ", proto)
	
	var message = {
		"uniquekey": Config.UNIQUE,
		"username": Config.config.user.username,
		"sessionFor": "SECOND",
		"stateForFirst": "",
		"stateForSecond":"STATE_CONNECT",
		"message": ""
	}
#	print("This is on connected Message : ", message)
	_send_data(message)
	
func _error_closed():
	print("Unexpected error ocuured ")
	LoadingScript.load_scene(self,"res://start/conn_error.tscn")

func _closed(was_clean):
	print("Closed, clean: ",was_clean)
	LoadingScript.load_scene(self,"res://start/conn_error.tscn")

# warning-ignore:unused_argument
func _on_slot_pressed(slotName,accessKey):
	Config.MUSIC.volume_db = -80
	
	var postman_url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotplayconnect/getplaylink"
	
	var data = {
	"accesskey": "",
	"gameProvider": "awc(jili)",
	"lang": "en",
	"game": accessKey,
	"gameName": accessKey,
	"isMobile": Config.config["web"]["isMobile"],
	"redirectLink": "",
	"type": Config.config["web"]["type"],
	"name": "",
	"session": "",
	"provider": "skme-mclub",
	"username": $"/root/Config".config.user.username,
	"beforeBalance": balance,
	"amount": 0,
	"afterBalance": 0,
	"raction": "",
	"rdealId": "",
	"rproviderName": "",
	"rremark": ""
}
	var headers = ["Content-Type: application/json"]
	var http = HTTPRequest.new()
	add_child(http)
	var body = JSON.print(data)

	if http.is_connected("request_completed",self,"on_body_request_completed"):
		http.disconnect("request_completed",self,"on_body_request_completed")
	http.connect("request_completed",self,"on_body_request_completed")
	http.request(postman_url,headers,false,HTTPClient.METHOD_POST,body)
	
	

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func on_body_request_completed(result, response_code, headers, body):
	var json_result = JSON.parse(body.get_string_from_utf8()).result
	Config.slot_url = json_result["url"]
	var play_data = {
		"uniquekey": Config.UNIQUE,
		"username": Config.config.user.username,
		"sessionFor": "SECOND",
		"stateForFirst": "",
		"stateForSecond":"STATE_PLAY",
		"message": Config.slot_url
	}
	_send_data(play_data)
	

func get_parameter(parameter):
	if OS.has_feature('JavaScript'):
		return JavaScript.eval(""" 
				var url_string = window.location.href;
				var url = new URL(url_string);
				url.searchParams.get(parameter);
			""")
	return null

func _on_Left_pressed():
	$slotAnimation.play("left")


func _on_Right_pressed():
	$slotAnimation.play("right")


func _on_slotAnimation_animation_finished(anim_name):
	if anim_name == "right":
		$Right.disabled = true
		$Right.texture_disabled = arrows["dull"]
		$Right.modulate = Color(.7,.7,.7,.85)
		$Left.flip_h = true
		$Left.disabled = false
		$Left.modulate = Color(1,1,1,1)
	else:
		$Left.disabled = true
		$Right.disabled = false
		$Left.modulate = Color(.7,.7,.7,.85)
		$Right.modulate = Color(1,1,1,1)


func _on_Back_pressed():
	Config.MUSIC.volume_db = -80
	var message = {
		"uniquekey": Config.UNIQUE,
		"username": Config.config.user.username,
		"sessionFor": "SECOND",
		"stateForFirst": "",
		"stateForSecond":"STATE_DISCONNECT",
		"message": ""
	}
	_send_data(message)
	
