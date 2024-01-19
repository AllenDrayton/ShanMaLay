extends Node2D

var slots = []
var websocket = WebSocketClient.new()
var websocket_url = "ws://redboxmm.tech:8081/acrf-qarava-slot/slotplaysocket"

var serverTimer = Timer.new()

var FISHSLOTS = {
	"Boom Legend" : "JILI-FISH-008",
	"Mega Fishing" : "JILI-FISH-007",
	"Dragon Fortune" : "JILI-FISH-006",
	"Happy Fishing" : "JILI-FISH-005",
	"Dinosaur Fishing" : "JILI-FISH-004",
	"Jackpot Fishing" : "JILI-FISH-003",
	"Bombing Fishing" : "JILI-FISH-002",
	"Royal Fishing" : "JILI-FISH-001",
	"All-star Fishing": "JILI-FISH-009",
}

var balance

func onServerTimeout():
	print("Timeout: STATE_READY not received within 30 seconds")
	LoadingScript.load_scene(self,"res://pck/scenes/menu.tscn")

func startServerTimer(waittime):
	serverTimer.wait_time = waittime
	serverTimer.start()
	$loadingScreen.show()
	disable_buttons(true)

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
	for i in $slotContainer/slotProviderContainer.get_children():
		i.disabled = disable

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
			serverTimer.stop()
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
	startServerTimer(10)
	
func _error_closed():
	print("Unexpected error ocuured ")
	LoadingScript.load_scene(self,"res://start/conn_error.tscn")

func _closed(was_clean):
	print("Closed, clean: ",was_clean)
	LoadingScript.load_scene(self,"res://start/conn_error.tscn")

func _ready():
	add_child(serverTimer)
	serverTimer.connect("timeout",self,"onServerTimeout")
	_connect_ws()
	
	loadTextures()
	request_http()
	
	if Signals.user_mute_music == true:
		Config.MUSIC.volume_db = -80
	elif Signals.user_mute_music == false:
		Config.MUSIC.volume_db = 0
		

func _process(delta):
	websocket.poll()

func request_http():
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_update_info")
	http.request(url)

func loadTextures():
	for i in range (1,10):
		var path = load("res://pck/assets/slots/fish assets/" + str(i) + ".png")
		slots.append(path)
	var container = $slotContainer/slotProviderContainer.get_children()
	for j in range(container.size()):
		var slot = container[j]
		if slot is TextureButton:
			slot.texture_normal = slots[j]

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
	

func on_fish_slot_pressed(slotName, accessKey):
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
	print(body)
	print(http.is_connected("request_completed",self,"on_body_request_completed"))
	if http.is_connected("request_completed",self,"on_body_request_completed"):
		http.disconnect("request_completed",self,"on_body_request_completed")
	http.connect("request_completed",self,"on_body_request_completed")
	http.request(postman_url,headers,false,HTTPClient.METHOD_POST,body)

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



func _on_Back_pressed():
	Config.MUSIC.volume_db = -80
	var quit_data = {
		"uniquekey": Config.UNIQUE,
		"username": Config.config.user.username,
		"sessionFor": "SECOND",
		"stateForFirst": "",
		"stateForSecond":"STATE_DISCONNECT",
		"message": Config.slot_url
	}
	_send_data(quit_data)
	
