extends Node2D

var slot_1_textures = []
var slot_2_textures = []

var canPress = true

var SLOTPAGE = 1


var JILISLOTS = {
	# 0 - 10
	"Hot Chilli": ["JILI-SLOT-002", preload("res://pck/assets/slots/assets/Hot Chilli.png")],
	"Chin Shi Huang": ["JILI-SLOT-003", preload("res://pck/assets/slots/assets/chin shi huang.png")],
	"War Of Dragons": ["JILI-SLOT-004", preload("res://pck/assets/slots/assets/War of Dragons.png")],
	"Fortune Tree": ["JILI-SLOT-005", preload("res://pck/assets/slots/assets/Fortune Tree.png")],
	"Lucky Ball": ["JILI-SLOT-006", preload("res://pck/assets/slots/assets/Lucky Ball.png")],
	"Hyper Burst": ["JILI-SLOT-007", preload("res://pck/assets/slots/assets/Hyper Burst.png")],
	"Shanghai Beauty": ["JILI-SLOT-008", preload("res://pck/assets/slots/assets/shenghai beauty.png")],
	"Fa Fa Fa": ["JILI-SLOT-009", preload("res://pck/assets/slots/assets/Fa Fa Fa.png")],
	"God Of Martial": ["JILI-SLOT-010", preload("res://pck/assets/slots/assets/God of Martial.png")],
	"Hawaii Beauty": ["JILI-SLOT-012", preload("res://pck/assets/slots/assets/Hawaii  Beauty.png")],
	# 10 - 20
	"SevenSevenSeven": ["JILI-SLOT-013", preload("res://pck/assets/slots/assets/777.png")],
	"Crazy777": ["JILI-SLOT-014", preload("res://pck/assets/slots/assets/Crazy777.png")],
	"Bubble Beauty": ["JILI-SLOT-015", preload("res://pck/assets/slots/assets/bubble beauty.png")],
	"Bao boon chin": ["JILI-SLOT-016", preload("res://pck/assets/slots/assets/bao boon chin.png")],
	"Crazy FaFaFa": ["JILI-SLOT-017", preload("res://pck/assets/slots/assets/Crazy fa fa fa.png")],
	"XiYangYang": ["JILI-SLOT-018", preload("res://pck/assets/slots/assets/XiYingYang.png")],
	"FortunePig": ["JILI-SLOT-019", preload("res://pck/assets/slots/assets/fortune pig.png")],
	"Candy Baby": ["JILI-SLOT-020", preload("res://pck/assets/slots/assets/Candy Baby.png")],
	"DiamondParty": ["JILI-SLOT-021", preload("res://pck/assets/slots/assets/diamond party.png")],
	"Fengshen": ["JILI-SLOT-022", preload("res://pck/assets/slots/assets/feng shen.png")],
	# 20 - 30
	"GoldenBank": ["JILI-SLOT-023", preload("res://pck/assets/slots/assets/golden bank.png")],
	"Lucky Goldbricks": ["JILI-SLOT-024", preload("res://pck/assets/slots/assets/Lucky Goldbricks.png")],
	"Charge Buffalo": ["JILI-SLOT-026", preload("res://pck/assets/slots/assets/charge buffalo.png")],
	"Super Ace": ["JILI-SLOT-027", preload("res://pck/assets/slots/assets/super ace.png")],
	"Jungle King": ["JILI-SLOT-028", preload("res://pck/assets/slots/assets/Jungle King.png")],
	"Money Coming": ["JILI-SLOT-029", preload("res://pck/assets/slots/assets/money coming.png")],
	"Golden Queen": ["JILI-SLOT-030", preload("res://pck/assets/slots/assets/Golden Queen.png")],
	"Boxing King": ["JILI-SLOT-031", preload("res://pck/assets/slots/assets/boxing king.png")],
	"Dice": ["JILI-SLOT-032", preload("res://pck/assets/slots/assets/Dice.png")],
	"DragonTiger": ["JILI-SLOT-032", preload("res://pck/assets/slots/assets/DragonTiger.png")],
	# 30 - 40
	"SevenUpDown": ["JILI-SLOT-032", preload("res://pck/assets/slots/assets/SevenUpDown.png")],
	"Lucky Number": ["JILI-SLOT-032", preload("res://pck/assets/slots/assets/Lucky Number.png")],
#	"Matka India": ["JILI-SLOT-032", preload("res://pck/assets/slots/assets/Matka India.png")],
	"Lucky Coming": ["JILI-SLOT-037", preload("res://pck/assets/slots/assets/Lucky Coming.png")],
	"Pharaoh Treasure": ["JILI-SLOT-038", preload("res://pck/assets/slots/assets/Pharoah Treasure.png")],
	"Secret Treasure": ["JILI-SLOT-039", preload("res://pck/assets/slots/assets/Secret Treasure.png")],
	"RomaX": ["JILI-SLOT-040", preload("res://pck/assets/slots/assets/RomaX.png")],
	"Super Rich": ["JILI-SLOT-041", preload("res://pck/assets/slots/assets/Super Rich.png")],
	"Golden Empire": ["JILI-SLOT-042", preload("res://pck/assets/slots/assets/golden empire.png")],
	"Fortune Gems": ["JILI-SLOT-043", preload("res://pck/assets/slots/assets/fortune gems.png")],
	# 40 - 50
	"Party Night": ["JILI-SLOT-044", preload("res://pck/assets/slots/assets/Party Night.png")],
	"Crazy Hunter": ["JILI-SLOT-045", preload("res://pck/assets/slots/assets/crazy hunter.png")],
	"Magic Lamp": ["JILI-SLOT-046", preload("res://pck/assets/slots/assets/Magic Lamp.png")],
	"TWINWINS": ["JILI-SLOT-047", preload("res://pck/assets/slots/assets/TWINWINS.png")],
	"Agent Ace": ["JILI-SLOT-048", preload("res://pck/assets/slots/assets/Agent Ace.png")],
	"Alibaba": ["JILI-SLOT-049", preload("res://pck/assets/slots/assets/alibaba.png")],
	"Medusa": ["JILI-SLOT-050", preload("res://pck/assets/slots/assets/Medusa.png")],
}
	
var filepath = "user://slotList.txt"

var serverTimer = Timer.new()

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


func onServerTimeout():
	$loadingScreen.hide()
	print("Timeout: STATE_READY not received within 10 seconds")
	LoadingScript.load_scene(self,"res://pck/scenes/menu.tscn")

func startServerTimer(waittime):
	serverTimer.wait_time = waittime
	serverTimer.start()
	$loadingScreen.show()
	disable_buttons(true)


func _ready():
	var keys_array = JILISLOTS.keys()
	# slot 1
	var slot1 = $slotContainer_1/slotProviderContainer.get_children()
	var count1 = 0
	for i in range(0, min(10, keys_array.size())): # 0 - 10
		var slot = slot1[count1]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = JILISLOTS[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count1 += 1
	# slot 2
	var slot2 = $slotContainer_2/slotProviderContainer.get_children()
	var count2 = 0
	for i in range(10, min(20, keys_array.size())): # 10 - 20
		var slot = slot2[count2]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = JILISLOTS[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count2 += 1
	# slot 3
	var slot3 = $slotContainer_3/slotProviderContainer.get_children()
	var count3 = 0
	for i in range(20, min(30, keys_array.size())): # 20 - 30
		var slot = slot3[count3]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = JILISLOTS[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count3 += 1
	# slot 4
	var slot4 = $slotContainer_4/slotProviderContainer.get_children()
	var count4 = 0
	for i in range(30, min(40, keys_array.size())): # 30 - 40
		var slot = slot4[count4]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = JILISLOTS[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count4 += 1
	# slot 5
	var slot5 = $slotContainer_5/slotProviderContainer.get_children()
	var count5 = 0
	for i in range(40, min(50, keys_array.size())): # 40 - 50
		var slot = slot5[count5]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		if JILISLOTS.has(name):
			slot.texture_normal = JILISLOTS[name][1]
			slot.connect("pressed", self, "_on_slot_pressed", [slot])
		else:
			slot.texture_normal = null
		count5 += 1
	$loadingScreen/Bg.hide()
	$loadingScreen.show();
	add_child(serverTimer)
	serverTimer.connect("timeout",self,"onServerTimeout")
	_connect_ws()
	$sliderButtons/Left.disabled = true
	$sliderButtons/Left.texture_disabled = arrows["dull"]
	$sliderButtons/Left.modulate = Color(.7,.7,.7,.85)
	
# warning-ignore:return_value_discarded
	$sliderButtons/Left.connect("pressed",self,"_on_Left_pressed",[SLOTPAGE])
# warning-ignore:return_value_discarded
	$sliderButtons/Right.connect("pressed",self,"_on_Right_pressed",[SLOTPAGE])

	
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
		LoadingScript.load_scene(self,"res://pck/scenes/menu.tscn")
	else:
		print("... Connecting")
		pass

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func on_balance_request_completed(result, response_code, headers, body):
	var json_result = JSON.parse(body.get_string_from_utf8()).result
	$Balance.text = comma_sep(json_result["balance"])


func balance_update():
	var http = HTTPRequest.new()
# warning-ignore:shadowed_variable
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
	$Back.disabled = disable
	for i in $slotContainer_1/slotProviderContainer.get_children():
		i.disabled = disable
	for ii in $slotContainer_2/slotProviderContainer.get_children():
		ii.disabled = disable
	for iii in $slotContainer_3/slotProviderContainer.get_children():
		iii.disabled = disable
	for iv in $slotContainer_4/slotProviderContainer.get_children():
		iv.disabled = disable
	for v in $slotContainer_5/slotProviderContainer.get_children():
		v.disabled = disable

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
			serverTimer.stop()
			balance_update()
			if Signals.user_mute_music == true:
				Config.MUSIC.volume_db = -80
			elif Signals.user_mute_music == false:
				Config.MUSIC.volume_db = 0
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


# warning-ignore:unused_argument
func _on_slot_pressed(button):
#	disable_buttons(true)
#	$loadingScreen.show()
	Config.MUSIC.volume_db = -80
	var name = button.name
	var accessKey = JILISLOTS[name][0]
# warning-ignore:unused_variable
#	var postman_url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotplayconnect/getplaylink"
	var postman_url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotplayconnect/getgamelink"
	print("Key :", accessKey, " name: ", name)
	
	var data = {
	"accesskey": "",
	"gameProvider": "AWC(JILI)",
	"lang": "en",
	"game": accessKey,
	"gameName": name,
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
	print("URL: ",Config.slot_url)
	
	var play_data = {
		"uniquekey": Config.UNIQUE,
		"username": Config.config.user.username,
		"sessionFor": "SECOND",
		"stateForFirst": "",
		"stateForSecond":"STATE_PLAY",
		"message": Config.slot_url
	}
	_send_data(play_data)
	

# warning-ignore:unused_argument
func get_parameter(parameter):
	if OS.has_feature('JavaScript'):
		return JavaScript.eval(""" 
				var url_string = window.location.href;
				var url = new URL(url_string);
				url.searchParams.get(parameter);
			""")
	return null
	
func _on_Right_pressed(slotPage): # +1
	if canPress == true:
		canPress = false
		if slotPage != SLOTPAGE:
			slotPage = SLOTPAGE
		var page = str(int(slotPage),"to",int(slotPage+1))
		print("Animation: ",page)
		$slotAnimation.play(page)
		$cooldown.start()
		SLOTPAGE += 1
	
func _on_Left_pressed(slotPage): # -1
	if canPress == true:
		canPress = false
		if slotPage != SLOTPAGE:
			slotPage = SLOTPAGE
		var page = str(int(slotPage),"to",int(slotPage-1))
		print("Animation: ",page)
		$slotAnimation.play(page)
		$cooldown.start()
		SLOTPAGE -= 1


func _on_slotAnimation_animation_finished(anim_name):
	if anim_name == "4to5": #2
		$sliderButtons/Right.disabled = true
		$sliderButtons/Right.texture_disabled = arrows["dull"]
		$sliderButtons/Right.modulate = Color(.7,.7,.7,.85)
		$sliderButtons/Left.flip_h = true
		$sliderButtons/Left.disabled = false
		$sliderButtons/Left.modulate = Color(1,1,1,1)
	elif anim_name == "5to4":
		$sliderButtons/Right.modulate = Color(1,1,1,1)
		$sliderButtons/Right.disabled = false
	elif anim_name == "2to1": #1
		$sliderButtons/Left.disabled = true
		$sliderButtons/Right.disabled = false
		$sliderButtons/Left.modulate = Color(.7,.7,.7,.85)
		$sliderButtons/Right.modulate = Color(1,1,1,1)
	elif anim_name == "1to2":
		$sliderButtons/Left.disabled = false
		$sliderButtons/Left.modulate = Color(1,1,1,1)


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
	LoadingScript.load_scene(self,"res://pck/scenes/menu.tscn")
	


func _on_cooldown_timeout():
	canPress = true
