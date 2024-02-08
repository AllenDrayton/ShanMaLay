extends Node

# This is JILI Script
var balance
var canPress = true
var Slot_Page = 1

# Web Socket Variables
export var websocket_url = "ws://redboxmm.tech:8081/acrf-qarava-slot/slotplaysocket"
var _client = WebSocketClient.new()
var isExit = false
var isPlaying = false

var slot_textures1 = []
var slot_textures2 = []

var filepath="res://pck/assets/slot/slot-game-AWC(KINGMAKER).json"
var acesskey
var game_name

var JILILIST = {
	# 0 - 10
	"Hot Chilli": ["JILI-SLOT-002", preload("res://pck/assets/slot/Jili/Hot Chilli.png")],
	"Chin Shi Huang": ["JILI-SLOT-003", preload("res://pck/assets/slot/Jili//chin shi huang.png")],
	"War Of Dragons": ["JILI-SLOT-004", preload("res://pck/assets/slot/Jili/War of Dragons.png")],
	"Fortune Tree": ["JILI-SLOT-005", preload("res://pck/assets/slot/Jili/Fortune Tree.png")],
	"Lucky Ball": ["JILI-SLOT-006", preload("res://pck/assets/slot/Jili/Lucky Ball.png")],
	"Hyper Burst": ["JILI-SLOT-007", preload("res://pck/assets/slot/Jili/Hyper Burst.png")],
	"Shanghai Beauty": ["JILI-SLOT-008", preload("res://pck/assets/slot/Jili/shenghai beauty.png")],
	"Fa Fa Fa": ["JILI-SLOT-009", preload("res://pck/assets/slot/Jili/Fa Fa Fa.png")],
	"God Of Martial": ["JILI-SLOT-010", preload("res://pck/assets/slot/Jili/God of Martial.png")],
	"Hawaii Beauty": ["JILI-SLOT-012", preload("res://pck/assets/slot/Jili/Hawaii  Beauty.png")],
	# 10 - 20
#	"SevenSevenSeven": ["JILI-SLOT-013", preload("res://pck/assets/slot/Jili/777.png")],
	"Crazy777": ["JILI-SLOT-014", preload("res://pck/assets/slot/Jili/Crazy777.png")],
	"Bubble Beauty": ["JILI-SLOT-015", preload("res://pck/assets/slot/Jili/Bubble Beauty.png")],
	"Bao boon chin": ["JILI-SLOT-016", preload("res://pck/assets/slot/Jili/bao boon chin.png")],
	"Crazy FaFaFa": ["JILI-SLOT-017", preload("res://pck/assets/slot/Jili/Crazy fa fa fa.png")],
	"XiYangYang": ["JILI-SLOT-018", preload("res://pck/assets/slot/Jili/XiYingYang.png")],
	"FortunePig": ["JILI-SLOT-019", preload("res://pck/assets/slot/Jili/fortune pig.png")],
	"Candy Baby": ["JILI-SLOT-020", preload("res://pck/assets/slot/Jili/Candy Baby.png")],
#	"DiamondParty": ["JILI-SLOT-021", preload("res://pck/assets/slot/Jili/diamond party.png")],
#	"Fengshen": ["JILI-SLOT-022", preload("res://pck/assets/slot/Jili/feng shen.png")],
	# 20 - 30
#	"GoldenBank": ["JILI-SLOT-023", preload("res://pck/assets/slot/Jili/golden bank.png")],
	"Lucky Goldbricks": ["JILI-SLOT-024", preload("res://pck/assets/slot/Jili/Lucky Goldbricks.png")],
	"Charge Buffalo": ["JILI-SLOT-026", preload("res://pck/assets/slot/Jili/charge buffalo.png")],
	"Super Ace": ["JILI-SLOT-027", preload("res://pck/assets/slot/Jili/super ace.png")],
	"Jungle King": ["JILI-SLOT-028", preload("res://pck/assets/slot/Jili/Jungle King.png")],
	"Money Coming": ["JILI-SLOT-029", preload("res://pck/assets/slot/Jili/money coming.png")],
	"Golden Queen": ["JILI-SLOT-030", preload("res://pck/assets/slot/Jili/Golden Queen.png")],
	"Boxing King": ["JILI-SLOT-031", preload("res://pck/assets/slot/Jili/Boxing King.png")],
	"Dice": ["JILI-SLOT-032", preload("res://pck/assets/slot/Jili/Dice.png")],
	"DragonTiger": ["JILI-SLOT-032", preload("res://pck/assets/slot/Jili/DragonTiger.png")],
	# 30 - 40
	"SevenUpDown": ["JILI-SLOT-032", preload("res://pck/assets/slot/Jili/SevenUpDown.png")],
	"Lucky Number": ["JILI-SLOT-032", preload("res://pck/assets/slot/Jili/Lucky Number.png")],
	"Matka India": ["JILI-SLOT-032", preload("res://pck/assets/slot/Jili/Matka India.png")],
	"Lucky Coming": ["JILI-SLOT-037", preload("res://pck/assets/slot/Jili/Lucky Coming.png")],
	"Pharaoh Treasure": ["JILI-SLOT-038", preload("res://pck/assets/slot/Jili/Pharoah Treasure.png")],
	"Secret Treasure": ["JILI-SLOT-039", preload("res://pck/assets/slot/Jili/Secret Treasure.png")],
	"RomaX": ["JILI-SLOT-040", preload("res://pck/assets/slot/Jili/RomaX.png")],
	"Super Rich": ["JILI-SLOT-041", preload("res://pck/assets/slot/Jili/Super Rich.png")],
	"Golden Empire": ["JILI-SLOT-042", preload("res://pck/assets/slot/Jili/golden empire.png")],
	"Fortune Gems": ["JILI-SLOT-043", preload("res://pck/assets/slot/Jili/fortune gems.png")],
	# 40 - 50
	"Party Night": ["JILI-SLOT-044", preload("res://pck/assets/slot/Jili/Party Night.png")],
	"Crazy Hunter": ["JILI-SLOT-045", preload("res://pck/assets/slot/Jili/crazy hunter.png")],
	"Magic Lamp": ["JILI-SLOT-046", preload("res://pck/assets/slot/Jili/Magic Lamp.png")],
	"TWINWINS": ["JILI-SLOT-047", preload("res://pck/assets/slot/Jili/TWINWINS.png")],
	"Agent Ace": ["JILI-SLOT-048", preload("res://pck/assets/slot/Jili/Agent Ace.png")],
	"Alibaba": ["JILI-SLOT-049", preload("res://pck/assets/slot/Jili/alibaba.png")],
	"Medusa": ["JILI-SLOT-050", preload("res://pck/assets/slot/Jili/Medusa.png")],
}


func initialize():
	var keys_array = JILILIST.keys()
	# slot 1
	var slot1 = $Slot_container1/p.get_children()
	var count1 = 0
	for i in range(0, min(10, keys_array.size())): # 0 - 10
		var slot = slot1[count1]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = JILILIST[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count1 += 1
	# slot 2
	var slot2 = $Slot_container2/p.get_children()
	var count2 = 0
	for i in range(10, min(20, keys_array.size())): # 10 - 20
		var slot = slot2[count2]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = JILILIST[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count2 += 1
	# slot 3
	var slot3 = $Slot_container3/p.get_children()
	var count3 = 0
	for i in range(20, min(30, keys_array.size())): # 20 - 30
		var slot = slot3[count3]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = JILILIST[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count3 += 1
	# slot 4
	var slot4 = $Slot_container4/p.get_children()
	var count4 = 0
	for i in range(30, min(40, keys_array.size())): # 30 - 40
		var slot = slot4[count4]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = JILILIST[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count4 += 1
	# slot 5
	var slot5 = $Slot_container5/p.get_children()
	var count5 = 0
	for i in range(40, min(50, keys_array.size())): # 40 - 50
		var slot = slot5[count5]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		if JILILIST.has(name):
			slot.texture_normal = JILILIST[name][1]
			slot.connect("pressed", self, "_on_slot_pressed", [slot])
		else:
			slot.texture_normal = null
		count5 += 1

func _ready():
	initialize()
# warning-ignore:return_value_discarded
	$left.connect("pressed",self,"_on_left_pressed",[Slot_Page])
# warning-ignore:return_value_discarded
	$right.connect("pressed",self,"_on_right_pressed",[Slot_Page])
	# For Slot Animation
	$Slot_Animation.play("RESET")
	
	$left.hide()
	$left.disabled = true
	
	# Waiting For Websocket Connection
	$Backdrop.show()
	_disabled_buttons()
	print("Show")
	
	if $Setting/SliderMusic.value == 0:
		$"/root/bgm".volume_db =  $Setting/SliderMusic.value
	else:
		$"/root/bgm".volume_db += 45
	
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	http.timeout = 5
	http.connect("request_completed",self,"_update_info")
	http.request(url)
	
#	_load_profile_textures()
	
	# For Implementing Web Socket
	_connect_websocket()


func _connect_websocket():
	_client.connect("connection_closed", self, "_on_connection_closed")
	_client.connect("connection_error", self, "_on_connection_error")
	_client.connect("connection_established", self, "_on_connected")
	_client.connect("data_received", self, "_on_data")
	
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to Connect")
		set_process(false)
		$"/root/bgm".volume_db = -50
		LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")


# warning-ignore:unused_argument
func _process(delta):
	_client.poll()
#	print(_client.get_connection_status())


func _on_connection_closed(was_clean = false):
	print("Websocket Connection Closed, clean : ", was_clean)
	set_process(false)

func _on_connection_error():
	print("Websocket Connection Error")

# Sending Data request to Web Socket
func _on_connected(proto = ""):
	# Send message to the WebSocket based on the stateForSecond
	print("Connection_Successful with Protocol : ", proto)
	
	var message = {
		"uniquekey": Config.UNIQUE,
		"username": Config.config.user.username,
		"sessionFor": "SECOND",
		"stateForFirst": "",
		"stateForSecond": "STATE_CONNECT",
		"message": ""
	}
	print("This is on connected Message : ", message)
	_send(message)
	
	$Websocket_timer.start()
	
#	$Backdrop.hide()
#	_enabled_buttons()
#	print("hide")


func _on_data():
	var message = _client.get_peer(1).get_packet().get_string_from_utf8()
	print("Received data from Server:", message)
	var obj = JSON.parse(message)
	var res = obj.result
	print("On data Respond after json parsing : ", res)
	
	# Handling different states
	match res.stateForFirst:
		
		"STATE_CONNECT":
			
			match res.stateForSecond:
				"STATE_CONNECT":
					print("Client has been Dinnected")
				"STATE_READY":
					$Backdrop.hide()
					_enabled_buttons()
				"STATE_PLAY":
					$Backdrop.show()
					_disabled_buttons()
				"STATE_DISCONNECT":
					print("Client has been Disconnected")
				"STATE_EXIT":
					$Timer.start()
					
		"STATE_READY":
			$Websocket_timer.stop()
			$Backdrop.hide()
			_enabled_buttons()
			print("hide")
			balance_update()
			print("READY TO GO TO SLOTTTTTTTTTTTTTTTTTTT!!!!")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("Client has been Dinnected")
				"STATE_READY":
					$Backdrop.hide()
					_enabled_buttons()
					if $Setting/SliderMusic.value == 0:
						$"/root/bgm".volume_db =  $Setting/SliderMusic.value
					else:
						$"/root/bgm".volume_db += 45
				"STATE_PLAY":
					$Backdrop.show()
					_disabled_buttons()
				"STATE_DISCONNECT":
					print("Client has been Disconnected")
				"STATE_EXIT":
					$Timer.start()
			
		"STATE_PLAY":
			
			print("State_play")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("Client has been Dinnected")
				"STATE_READY":
					$Backdrop.hide()
					_enabled_buttons()
				"STATE_PLAY":
					$Backdrop.show()
					_disabled_buttons()
				"STATE_DISCONNECT":
					print("Client has been Disconnected")
				"STATE_EXIT":
					$Timer.start()
			
		"STATE_DISCONNECT":
			
			print("State_disconnect")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("Client has been Dinnected")
				"STATE_READY":
					$Backdrop.hide()
					_enabled_buttons()
				"STATE_PLAY":
					$Backdrop.show()
					_disabled_buttons()
				"STATE_DISCONNECT":
					print("Client has been Disconnected")
				"STATE_EXIT":
					$Timer.start()
			
		"STATE_EXIT":
			
			print("state_exit")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("Client has been Dinnected")
				"STATE_READY":
					$Backdrop.hide()
					_enabled_buttons()
				"STATE_PLAY":
					$Backdrop.show()
					_disabled_buttons()
				"STATE_DISCONNECT":
					print("Client has been Disconnected")
				"STATE_EXIT":
					$Timer.start()
					
		"":
			
			print("Legit Disconnected")
			match res.stateForSecond:
				"STATE_CONNECT":
					print("Client has been Dinnected")
				"STATE_READY":
					$Backdrop.hide()
					_enabled_buttons()
				"STATE_PLAY":
					$Backdrop.show()
					_disabled_buttons()
				"STATE_DISCONNECT":
					print("Client has been Disconnected")
				"STATE_EXIT":
					print("Exit Slot Game!!!!!!!!!!!!!!")
			

func _send(data):
	var json = JSON.print(data)
	print("From client --- " + json)
#	var success = _client.get_peer(1).put_packet(json.to_utf8())
	var peer = _client.get_peer(1)
	
	# Set the write mode to WebSocketPeer.WRITE_MODE_TEXT
	peer.set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	
	# Convert the JSON string to UTF-8 and send it as a text packet
	var data_utf8 = json.to_utf8()
	var success = peer.put_packet(data_utf8)
	
	if success != OK:
		print("Failed to send data.")
	else:
		print("Data Has Been Sent Successfully")


# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _update_info(result, response_code, headers, body):
	print("This is Jili Respond code : ", response_code)
	if response_code != 200:
		$"/root/bgm".volume_db = -50
		LoadingScript.load_scene(self, "res://start/conn_error.tscn")
	else:
		var json_parse_result = JSON.parse(body.get_string_from_utf8())
		if json_parse_result.error != OK:
			print("Error: JSON parsing failed -", json_parse_result.error)
		else:
			var respond = json_parse_result.result
#			var respond = JSON.parse(body.get_string_from_utf8()).result
			balance = respond.balance
			$Balance/Label.text = comma_sep(respond.balance)


func comma_sep(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""
	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]
	return res

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func on_balance_request_completed(result, response_code, headers, body):
	var json_result = JSON.parse(body.get_string_from_utf8()).result
	$Balance/Label.text = comma_sep(json_result["balance"])

func balance_update():
	var http = HTTPRequest.new()
	var url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotuserconnect/getuserbalance/"+$"/root/Config".config.user.username
	add_child(http)
	http.connect("request_completed",self,"on_balance_request_completed")
	http.request(url)


func _on_Exit_pressed():
	isExit = true
	
	var message = {
		"uniquekey": Config.UNIQUE,
		"username": Config.config.user.username,
		"sessionFor": "SECOND",
		"stateForFirst": "",
		"stateForSecond": "STATE_DISCONNECT",
		"message": ""
	}
	print("This is on Exit Message : ", message)
	_send(message)
	
	$Timer.start()
#	# For Music
#	$"/root/bgm".volume_db = -50
#	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")

func _on_slot_pressed(button):
	
	$Backdrop.show()
	_disabled_buttons()
	
	isPlaying = true
	# For Music
	$"/root/bgm".volume_db = -50
	var name = button.name
	var accessKey = JILILIST[name][0]
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
	print("THis is BOdy : ", body)
	print(http.is_connected("request_completed",self,"on_body_request_completed"))
	if http.is_connected("request_completed",self,"on_body_request_completed"):
		http.disconnect("request_completed",self,"on_body_request_completed")
	http.connect("request_completed",self,"on_body_request_completed")
	http.request(postman_url,headers,false,HTTPClient.METHOD_POST,body)
	
# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func on_body_request_completed(result, response_code, headers, body):
	var json_result = JSON.parse(body.get_string_from_utf8()).result
	print("This is Respond Jason Result : ", json_result)
	Config.slot_url = json_result["url"]
	print("THis is slot_link : ", Config.slot_url)
#	OS.shell_open(Config.slot_url)
	
	var message = {
		"uniquekey": Config.UNIQUE,
		"username": Config.config.user.username,
		"sessionFor": "SECOND",
		"stateForFirst": "",
		"stateForSecond": "STATE_PLAY",
		"message": Config.slot_url
	}
	print("This is on Slot pressed Message : ", message)
	_send(message)



func _on_Timer_timeout():
	# For Music
	$"/root/bgm".volume_db = -50
	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")

func _disabled_buttons():
	$Exit.disabled = true
	
	var slot1 = $Slot_container1/p.get_children()
	for j in range(slot1.size()):
		var slot = slot1[j]
		slot.disabled = true
	var slot2 = $Slot_container2/p.get_children()
	for k in range(slot2.size()):
		var slot = slot2[k]
		slot.disabled = true
	var slot3 = $Slot_container3/p.get_children()
	for l in range(slot3.size()):
		var slot = slot3[l]
		slot.disabled = true
	var slot4 = $Slot_container4/p.get_children()
	for m in range(slot4.size()):
		var slot = slot4[m]
		slot.disabled = true
	var slot5 = $Slot_container5/p.get_children()
	for n in range(slot5.size()):
		var slot = slot5[n]
		slot.disabled = true
		

func _enabled_buttons():
	$Exit.disabled = false
	
	var slot1 = $Slot_container1/p.get_children()
	for j in range(slot1.size()):
		var slot = slot1[j]
		slot.disabled = false
	var slot2 = $Slot_container2/p.get_children()
	for k in range(slot2.size()):
		var slot = slot2[k]
		slot.disabled = false
	var slot3 = $Slot_container3/p.get_children()
	for l in range(slot3.size()):
		var slot = slot3[l]
		slot.disabled = false
	var slot4 = $Slot_container4/p.get_children()
	for m in range(slot4.size()):
		var slot = slot4[m]
		slot.disabled = false
	var slot5 = $Slot_container5/p.get_children()
	for n in range(slot5.size()):
		var slot = slot5[n]
		slot.disabled = false


func _on_right_pressed(slot_page_no):
	if canPress == true:
		canPress = false
		if slot_page_no != Slot_Page:
			slot_page_no = Slot_Page
		var page = str(int(slot_page_no),"to",int(slot_page_no + 1))
		print("Animation: ",page)
		$Slot_Animation.play(page)
		$cooldown.start()
		Slot_Page += 1


func _on_left_pressed(slot_page_no):
	if canPress == true:
		canPress = false
		if slot_page_no != Slot_Page:
			slot_page_no = Slot_Page
		var page = str(int(slot_page_no),"to",int(slot_page_no - 1))
		print("Animation: ",page)
		$Slot_Animation.play(page)
		$cooldown.start()
		Slot_Page -= 1


func _on_Slot_Animation_animation_finished(anim_name):
	match anim_name:
		
		"2to1":
			$left.hide()
			$left.disabled = true
			
			$right.show()
			$right.disabled = false
			
		"3to4":
			$right.hide()
			$right.disabled = true
			
			$left.show()
			$left.disabled = false
			
		"4to3":
			$right.show()
			$right.disabled = false
			
		"1to2":
			$left.show()
			$left.disabled = false


func _on_Websocket_timer_timeout():
	$"/root/bgm".volume_db = -50
	$Backdrop.hide()
	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")


func _on_cooldown_timeout():
	canPress = true
