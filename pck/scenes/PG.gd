extends Node2D

onready var slotsPlaceholder = preload("res://pck/assets/menu/slot.png")
export var websocket_url = "ws://redboxmm.tech:8081/acrf-qarava-slot/slotplaysocket"
var _client = WebSocketClient.new()
var balance = 0

var PGLIST = {
	#1
	"Fruity Candy": ["1397455", preload("res://pck/assets/slot/PG/fruity candy.png")],
	"Songkran Splash": ["1448762", preload("res://pck/assets/slot/PG/songkran.png")],
	"Leprechaun Riches": ["60", preload("res://pck/assets/slot/PG/leprachun.png")],
	"Hawaiian Tiki": ["1381200", preload("res://pck/assets/slot/PG/hawaian.png")],
	"Fortune Rabbit": ["1543462", preload("res://pck/assets/slot/PG/fortune rabbit.png")],
	"Emperor's Favour": ["44", preload("res://pck/assets/slot/PG/empire\'s favor.png")],
	"Dragon Hatch": ["57", preload("res://pck/assets/slot/PG/dragon hatch.png")],
	"Dragon Legend": ["29", preload("res://pck/assets/slot/PG/dragon legend.png")],
	"Midas Fortune": ["1402846", preload("res://pck/assets/slot/PG/midas fortune.png")],
	"Asgardian Rising": ["1340277", preload("res://pck/assets/slot/PG/asgardian rising.png")],
	#2
	"Captain's Bounty": ["54", preload("res://pck/assets/slot/PG/captain bounty.png")],
	"Ganesha Fortune": ["75", preload("res://pck/assets/slot/PG/genesha fortune.png")],
	"Gem Saviour Conquest": ["62", preload("res://pck/assets/slot/PG/gemsavour conquest].png")],
	"Journey to the Wealth": ["50", preload("res://pck/assets/slot/PG/journey to the wealth.png")],
	"Medusa 1: the Curse of Athena": ["7", preload("res://pck/assets/slot/PG/medusa 1.png")],
	"Dreams of Macau": ["79", preload("res://pck/assets/slot/PG/dreams of macau.png")],
	"Fortune Ox": ["98", preload("res://pck/assets/slot/PG/fortune ox.png")],
	"Win Win Won": ["24", preload("res://pck/assets/slot/PG/win win won.png")],
	"Medusa 2: the Quest of Perseus": ["6", preload("res://pck/assets/slot/PG/medusa 2.png")],
	"Mr. Hallow-Win!": ["35", preload("res://pck/assets/slot/PG/mr. halloween.png")],
	#3
	"Santa's Gift Rush": ["37", preload("res://pck/assets/slot/PG/santa\'s gift.png")],
	"Symbols Of Egypt": ["41", preload("res://pck/assets/slot/PG/symbols of egypt.png")],
	"Vampire's Charm": ["58", preload("res://pck/assets/slot/PG/vampire charm.png")],
	"CaiShen Wins": ["71", preload("res://pck/assets/slot/PG/caishen win.png")],
	"Egypt's Book of Mystery": ["73", preload("res://pck/assets/slot/PG/egypt book of mysteruy.png")],
	"Guardians of Ice & Fire": ["91", preload("res://pck/assets/slot/PG/guardian of ice and fire.png")],
	"Hood vs Wolf": ["18", preload("res://pck/assets/slot/PG/hood vs wolf.png")],
	"Hotpot": ["28", preload("res://pck/assets/slot/PG/hotpot.png")],
	"Legend of Hou Yi": ["34", preload("res://pck/assets/slot/PG/legend of hau yi.png")],
	"Prosperity Lion": ["36", preload("res://pck/assets/slot/PG/prospertiy lion.png")],
	#4
	"Hip Hop Panda": ["33", preload("res://pck/assets/slot/PG/hip hop panda.png")],
	"Fortune Gods": ["3", preload("res://pck/assets/slot/PG/fortune gods.png")],
	"Double Fortune": ["48", preload("res://pck/assets/slot/PG/48.png")],
	"Genie's 3 Wishes": ["85", preload("res://pck/assets/slot/PG/genie\'s 3 wishes.png")],
	"Treasures of Aztec": ["87", preload("res://pck/assets/slot/PG/treasure of azetch.png")],
	"The Great Icescape": ["53", preload("res://pck/assets/slot/PG/the great icesceape.png")],
	"Heist of Stakes": ["105", preload("res://pck/assets/slot/PG/heist of stakes.png")],
	"Jack Frost's Winter": ["97", preload("res://pck/assets/slot/PG/jaskfrost winter.png")],
	"Secrets of Cleopatra": ["90", preload("res://pck/assets/slot/PG/secrets of cleopatra.png")],
	"Majestic Treasures": ["95", preload("res://pck/assets/slot/PG/majestic treaurse.png")],
	#5
	"Mahjong Ways": ["65", preload("res://pck/assets/slot/PG/majhong ways.png")],
	"Queen of Bounty": ["84", preload("res://pck/assets/slot/PG/queen of bounty.png")],
	"Ways of the Qilin": ["106", preload("res://pck/assets/slot/PG/ways of qilin.png")],
	"Plushie Frenzy": ["25", preload("res://pck/assets/slot/PG/plushie frenzy.png")],
	"Jewels of Prosperity": ["88", preload("res://pck/assets/slot/PG/jewels of prospertiy.png")],
	"Muay Thai Champion": ["64", preload("res://pck/assets/slot/PG/mhwy thai.png")],
	"The Queen's Banquet": ["120", preload("res://pck/assets/slot/PG/the queens banquet.png")],
	"Battleground Royale": ["124", preload("res://pck/assets/slot/PG/battleground royale.png")],
	"Win Win Fish Prawn Crab": ["129", preload("res://pck/assets/slot/PG/win win fish prawn.png")],
	"Wild Bandito": ["104", preload("res://pck/assets/slot/PG/wild bantido.png")],
}



# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Backdrop.show()
	_disabled_buttons()
	
	$PGAnimation.play("RESET")
	
	var slots1 = $Slot_container1/p.get_children()
	for i in slots1:
		i.connect("pressed",self,"_on_slot_pressed",[i])
		var name = i.get_name()
		i.texture_normal = PGLIST[name][1]
		
	var slots2 = $Slot_container2/p.get_children()
	for ii in slots2:
		ii.connect("pressed",self,"_on_slot_pressed",[ii])
		var name = ii.get_name()
		if name == "Medusa 1 the Curse of Athena":
			name = "Medusa 1: the Curse of Athena"
		elif name == "Medusa 2 the Quest of Perseus":
			name = "Medusa 2: the Quest of Perseus"
		elif name == "Mr Hallow-Win!":
			name = "Mr. Hallow-Win!"
		ii.texture_normal = PGLIST[name][1]
		
	var slots3 = $Slot_container3/p.get_children()
	for iii in slots3:
		iii.connect("pressed",self,"_on_slot_pressed",[iii])
		var name = iii.get_name()
		iii.texture_normal = PGLIST[name][1]
		
	var slot4 = $Slot_container4/p.get_children()
	for iv in slot4:
		iv.connect("pressed",self,"_on_slot_pressed",[iv])
		var name = iv.get_name()
		iv.texture_normal = PGLIST[name][1]
	
	var slot5 = $Slot_container5/p.get_children()
	for v in slot5:
		v.connect("pressed",self,"_on_slot_pressed",[v])
		var name = v.get_name()
		v.texture_normal = PGLIST[name][1]
		
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	http.timeout = 5
	http.connect("request_completed",self,"_update_info")
	http.request(url)
	
	if $Setting/SliderMusic.value == 0:
		$"/root/bgm".volume_db =  $Setting/SliderMusic.value
	else:
		$"/root/bgm".volume_db += 45
	
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

func _enabled_buttons():
	
	$Exit.disabled = false
	
	$Slot_container1.show()
	$Slot_container2.show()
	$Slot_container3.show()
	$Slot_container4.show()
	$Slot_container5.show()
	
func _disabled_buttons():
	
	$Exit.disabled = true
	
	$Slot_container1.hide()
	$Slot_container2.hide()
	$Slot_container3.hide()
	$Slot_container4.hide()
	$Slot_container5.hide()

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

func on_balance_request_completed(result, response_code, headers, body):
	var json_result = JSON.parse(body.get_string_from_utf8()).result
	$Balance/Label.text = comma_sep(json_result["balance"])

func balance_update():
	var http = HTTPRequest.new()
	var url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotuserconnect/getuserbalance/"+$"/root/Config".config.user.username
	add_child(http)
	http.connect("request_completed",self,"on_balance_request_completed")
	http.request(url)
		
func _on_slot_pressed(button):
	
	$Backdrop.show()
	_disabled_buttons()
	
	# For Music
	$"/root/bgm".volume_db = -50
	
	var name = button.name
	if button.name == "Medusa 1 the Curse of Athena":
		name = "Medusa 1: the Curse of Athena"
	elif button.name == "Medusa 2 the Quest of Perseus":
		name = "Medusa 2: the Quest of Perseus"
	elif button.name == "Mr Hallow-Win!":
		name = "Mr. Hallow-Win!"
	var accesskey = PGLIST[name][0]
	print(name,": ",accesskey)
	
	var postman_url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotplayconnect/getplaylink"
	
	var data = {
	"accesskey": "",
	"gameProvider": "pg",
	"lang": "en",
	"game": accesskey,
	"gameName": name,
	"isMobile": Config.config["web"]["isMobile"],
	"redirectLink": "",
	"type": Config.config["web"]["type"],
	"name": "",
	"session": "",
	"provider": "SML99",
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
	
func on_body_request_completed(result, response_code, headers, body):
	var json_result = JSON.parse(body.get_string_from_utf8()).result
	print("This is Respond Jason Result : ", json_result)
	Config.slot_url = json_result["url"]
	print("THis is slot_link : ", Config.slot_url)
	
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
	

func disableButtons(names):
	for i in $animationControlButtons/Right.get_children():
		if names.find(i.name) != -1:
			i.disabled = false
			i.show()
		else:
			i.disabled = true
			i.hide()

			
	for j in $animationControlButtons/Left.get_children():
		if names.find(j.name) != -1:
			j.disabled = false
			j.show()
		else:
			j.disabled = true
			j.hide()


func _on_PGAnimation_animation_finished(anim_name):
	match anim_name:
		# Rights
		"1to2":
			disableButtons(["2to3","2to1"])
			print("2!")
		"2to3":
			disableButtons(["3to4","3to2"])
			print("3!")
		"3to4":
			disableButtons(["4to5","4to3"])
			print("4!")
		"4to5":
			disableButtons(["5to4"])
			print("5!")
		# Lefts
		"5to4":
			disableButtons(["4to3","4to5"])
			print("4!")
		"4to3":
			disableButtons(["3to2","3to4"])
			print("3!")
		"3to2":
			disableButtons(["2to1","2to3"])
			print("2!")
		"2to1":
			disableButtons(["1to2"])
			print("1!")

func _on_1to2_pressed():
	$PGAnimation.play("1to2")


func _on_2to3_pressed():
	$PGAnimation.play("2to3")


func _on_3to4_pressed():
	$PGAnimation.play("3to4")


func _on_4to5_pressed():
	$PGAnimation.play("4to5")


func _on_5to4_pressed():
	$PGAnimation.play("5to4")


func _on_4to3_pressed():
	$PGAnimation.play("4to3")


func _on_3to2_pressed():
	$PGAnimation.play("3to2")


func _on_2to1_pressed():
	$PGAnimation.play("2to1")


func _on_Exit_pressed():
	$Timer.start()


func _on_Timer_timeout():
	# For Music
	$"/root/bgm".volume_db = -50
	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")


func _on_Websocket_timer_timeout():
	$"/root/bgm".volume_db = -50
	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")
