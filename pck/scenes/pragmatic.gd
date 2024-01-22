extends Node

# This is Pragmatic Script
var balance

# Web Socket Variables
export var websocket_url = "ws://redboxmm.tech:8081/acrf-qarava-slot/slotplaysocket"
var _client = WebSocketClient.new()
var isExit = false
var isPlaying = false

var slot_textures1 = []
var slot_textures2 = []
var slot_textures3 = []
var slot_textures4 = []
var slot_textures5 = []
var slot_textures6 = []
var slot_textures7 = []
var slot_textures8 = []
var slot_textures9 = []

var filepath="res://pck/assets/slot/slot-game-AWC(KINGMAKER).json"
var acesskey
var game_name

func _load_profile_textures():
	for i in range(10):
		var path = "res://pck/assets/slot/pragmatic/" + str(i+1) + ".png"
		var texture = load(path)
		slot_textures1.append(texture)
	for ii in range(10,20):
		var path = "res://pck/assets/slot/pragmatic/" + str(ii+1) + ".png"
		var texture = load(path)
		slot_textures2.append(texture)
	for iii in range(20,30):
		var path = "res://pck/assets/slot/pragmatic/" + str(iii+1) + ".png"
		var texture = load(path)
		slot_textures3.append(texture)
	for iiii in range(30,40):
		var path = "res://pck/assets/slot/pragmatic/" + str(iiii+1) + ".png"
		var texture = load(path)
		slot_textures4.append(texture)
	for iiiii in range(40,50):
		var path = "res://pck/assets/slot/pragmatic/" + str(iiiii+1) + ".png"
		var texture = load(path)
		slot_textures5.append(texture)
	for iiiiii in range(50,60):
		var path = "res://pck/assets/slot/pragmatic/" + str(iiiiii+1) + ".png"
		var texture = load(path)
		slot_textures6.append(texture)
	for iiiiiii in range(60,70):
		var path = "res://pck/assets/slot/pragmatic/" + str(iiiiiii+1) + ".png"
		var texture = load(path)
		slot_textures7.append(texture)
	for iiiiiiii in range(70,80):
		var path = "res://pck/assets/slot/pragmatic/" + str(iiiiiiii+1) + ".png"
		var texture = load(path)
		slot_textures8.append(texture)
	for iiiiiiiii in range(80,82):
		var path = "res://pck/assets/slot/pragmatic/" + str(iiiiiiiii+1) + ".png"
		var texture = load(path)
		slot_textures9.append(texture)
	
	var slot1 = $Slot_container1/p1.get_children()
	for j in range(slot1.size()):
		var slot = slot1[j]
		if slot is TextureButton:
			slot.texture_normal = slot_textures1[j]
	var slot2 = $Slot_container2/p2.get_children()
	for k in range(slot2.size()):
		var slot = slot2[k]
		if slot is TextureButton:
			slot.texture_normal = slot_textures2[k]
	var slot3 = $Slot_container3/p3.get_children()
	for l in range(slot3.size()):
		var slot = slot3[l]
		if slot is TextureButton:
			slot.texture_normal = slot_textures3[l]
	var slot4 = $Slot_container4/p4.get_children()
	for m in range(slot4.size()):
		var slot = slot4[m]
		if slot is TextureButton:
			slot.texture_normal = slot_textures4[m]
	var slot5 = $Slot_container5/p5.get_children()
	for n in range(slot5.size()):
		var slot = slot5[n]
		if slot is TextureButton:
			slot.texture_normal = slot_textures5[n]
	var slot6 = $Slot_container6/p6.get_children()
	for o in range(slot6.size()):
		var slot = slot6[o]
		if slot is TextureButton:
			slot.texture_normal = slot_textures6[o]
	var slot7 = $Slot_container7/p7.get_children()
	for p in range(slot7.size()):
		var slot = slot7[p]
		if slot is TextureButton:
			slot.texture_normal = slot_textures7[p]
	var slot8 = $Slot_container8/p8.get_children()
	for q in range(slot8.size()):
		var slot = slot8[q]
		if slot is TextureButton:
			slot.texture_normal = slot_textures8[q]
	var slot9 = $Slot_container9/p9.get_children()
	for r in range(slot9.size()):
		var slot = slot9[r]
		if slot is TextureButton:
			slot.texture_normal = slot_textures9[r]




func _ready():
	
	# For Slot Animation
	$Slot_Animation.play("RESET")
	
	$one2two.show()
	
	$two2three.hide()
	
	$three2four.hide()
	
	$four2five.hide()
	
	$five2six.hide()
	
	$six2seven.hide()
	
	$seven2eight.hide()
	
	$eight2nine.hide()
	
	$nine2eight.hide()
	
	$eight2seven.hide()
	
	$seven2six.hide()
	
	$six2five.hide()
	
	$five2four.hide()
	
	$four2three.hide()
	
	$three2two.hide()
	
	$two2one.hide()
	
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
	
	_load_profile_textures()
	
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
					print("Exit Slot Game!!!!!!!!!!!!!!!!!!!!")
			

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

func _on_game_pressed(game_name,accesskey):
	
	$Backdrop.show()
	_disabled_buttons()
#
#	isPlaying = true
	# For Music
	$"/root/bgm".volume_db = -50
	
	print(game_name,",",accesskey)
	
	var postman_url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotplayconnect/getplaylink"

	var data = {
	"accesskey": "",
	"gameProvider": "pragmatic",
	"lang": "en",
	"game": accesskey,
	"gameName": game_name,
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
	
	var slot1 = $Slot_container1/p1.get_children()
	for j in range(slot1.size()):
		var slot = slot1[j]
		slot.disabled = true
	var slot2 = $Slot_container2/p2.get_children()
	for k in range(slot2.size()):
		var slot = slot2[k]
		slot.disabled = true
	var slot3 = $Slot_container3/p3.get_children()
	for l in range(slot3.size()):
		var slot = slot3[l]
		slot.disabled = true
	var slot4 = $Slot_container4/p4.get_children()
	for m in range(slot4.size()):
		var slot = slot4[m]
		slot.disabled = true
	var slot5 = $Slot_container5/p5.get_children()
	for n in range(slot5.size()):
		var slot = slot5[n]
		slot.disabled = true
	var slot6 = $Slot_container6/p6.get_children()
	for o in range(slot6.size()):
		var slot = slot6[o]
		slot.disabled = true
	var slot7 = $Slot_container7/p7.get_children()
	for p in range(slot7.size()):
		var slot = slot7[p]
		slot.disabled = true
	var slot8 = $Slot_container8/p8.get_children()
	for q in range(slot8.size()):
		var slot = slot8[q]
		slot.disabled = true
	var slot9 = $Slot_container9/p9.get_children()
	for r in range(slot9.size()):
		var slot = slot9[r]
		slot.disabled = true

func _enabled_buttons():
	$Exit.disabled = false
	
	var slot1 = $Slot_container1/p1.get_children()
	for j in range(slot1.size()):
		var slot = slot1[j]
		slot.disabled = false
	var slot2 = $Slot_container2/p2.get_children()
	for k in range(slot2.size()):
		var slot = slot2[k]
		slot.disabled = false
	var slot3 = $Slot_container3/p3.get_children()
	for l in range(slot3.size()):
		var slot = slot3[l]
		slot.disabled = false
	var slot4 = $Slot_container4/p4.get_children()
	for m in range(slot4.size()):
		var slot = slot4[m]
		slot.disabled = false
	var slot5 = $Slot_container5/p5.get_children()
	for n in range(slot5.size()):
		var slot = slot5[n]
		slot.disabled = false
	var slot6 = $Slot_container6/p6.get_children()
	for o in range(slot6.size()):
		var slot = slot6[o]
		slot.disabled = false
	var slot7 = $Slot_container7/p7.get_children()
	for p in range(slot7.size()):
		var slot = slot7[p]
		slot.disabled = false
	var slot8 = $Slot_container8/p8.get_children()
	for q in range(slot8.size()):
		var slot = slot8[q]
		slot.disabled = false
	var slot9 = $Slot_container9/p9.get_children()
	for r in range(slot9.size()):
		var slot = slot9[r]
		slot.disabled = false


func _on_Websocket_timer_timeout():
	$"/root/bgm".volume_db = -50
	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")


func _on_one2two_pressed():
	$Slot_Animation.play("one2two")


func _on_two2three_pressed():
	$Slot_Animation.play("two2three")


func _on_three2four_pressed():
	$Slot_Animation.play("three2four")


func _on_four2five_pressed():
	$Slot_Animation.play("four2five")


func _on_five2six_pressed():
	$Slot_Animation.play("five2six")


func _on_six2seven_pressed():
	$Slot_Animation.play("six2seven")


func _on_seven2eight_pressed():
	$Slot_Animation.play("seven2eight")


func _on_eight2nine_pressed():
	$Slot_Animation.play("eight2nine")


func _on_nine2eight_pressed():
	$Slot_Animation.play("nine2eight")


func _on_eight2seven_pressed():
	$Slot_Animation.play("eight2seven")


func _on_seven2six_pressed():
	$Slot_Animation.play("seven2six")


func _on_six2five_pressed():
	$Slot_Animation.play("six2five")


func _on_five2four_pressed():
	$Slot_Animation.play("five2four")


func _on_four2three_pressed():
	$Slot_Animation.play("four2three")


func _on_three2two_pressed():
	$Slot_Animation.play("three2two")


func _on_two2one_pressed():
	$Slot_Animation.play("two2one")


func _on_Slot_Animation_animation_finished(anim_name):
	match anim_name:
		
		"one2two":
			
			$one2two.hide()
			
			$two2three.show()
			
			$three2four.hide()
			
			$four2five.hide()
			
			$five2six.hide()
			
			$six2seven.hide()
			
			$seven2eight.hide()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.hide()
			
			$six2five.hide()
			
			$five2four.hide()
			
			$four2three.hide()
			
			$three2two.hide()
			
			$two2one.show()
		
		"two2three":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.show()
			
			$four2five.hide()
			
			$five2six.hide()
			
			$six2seven.hide()
			
			$seven2eight.hide()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.hide()
			
			$six2five.hide()
			
			$five2four.hide()
			
			$four2three.hide()
			
			$three2two.show()
			
			$two2one.hide()
			
		"three2four":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.hide()
			
			$four2five.show()
			
			$five2six.hide()
			
			$six2seven.hide()
			
			$seven2eight.hide()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.hide()
			
			$six2five.hide()
			
			$five2four.hide()
			
			$four2three.show()
			
			$three2two.hide()
			
			$two2one.hide()
			
		"four2five":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.hide()
			
			$four2five.hide()
			
			$five2six.show()
			
			$six2seven.hide()
			
			$seven2eight.hide()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.hide()
			
			$six2five.hide()
			
			$five2four.show()
			
			$four2three.hide()
			
			$three2two.hide()
			
			$two2one.hide()
			
		"five2six":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.hide()
			
			$four2five.hide()
			
			$five2six.hide()
			
			$six2seven.show()
			
			$seven2eight.hide()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.hide()
			
			$six2five.show()
			
			$five2four.hide()
			
			$four2three.hide()
			
			$three2two.hide()
			
			$two2one.hide()
			
		"six2seven":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.hide()
			
			$four2five.hide()
			
			$five2six.hide()
			
			$six2seven.hide()
			
			$seven2eight.show()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.show()
			
			$six2five.hide()
			
			$five2four.hide()
			
			$four2three.hide()
			
			$three2two.hide()
			
			$two2one.hide()
			
		"seven2eight":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.hide()
			
			$four2five.hide()
			
			$five2six.hide()
			
			$six2seven.hide()
			
			$seven2eight.hide()
			
			$eight2nine.show()
			
			$nine2eight.hide()
			
			$eight2seven.show()
			
			$seven2six.hide()
			
			$six2five.hide()
			
			$five2four.hide()
			
			$four2three.hide()
			
			$three2two.hide()
			
			$two2one.hide()
			
		"eight2nine":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.hide()
			
			$four2five.hide()
			
			$five2six.hide()
			
			$six2seven.hide()
			
			$seven2eight.hide()
			
			$eight2nine.hide()
			
			$nine2eight.show()
			
			$eight2seven.hide()
			
			$seven2six.hide()
			
			$six2five.hide()
			
			$five2four.hide()
			
			$four2three.hide()
			
			$three2two.hide()
			
			$two2one.hide()
			
		"nine2eight":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.hide()
			
			$four2five.hide()
			
			$five2six.hide()
			
			$six2seven.hide()
			
			$seven2eight.hide()
			
			$eight2nine.show()
			
			$nine2eight.hide()
			
			$eight2seven.show()
			
			$seven2six.hide()
			
			$six2five.hide()
			
			$five2four.hide()
			
			$four2three.hide()
			
			$three2two.hide()
			
			$two2one.hide()
			
		"eight2seven":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.hide()
			
			$four2five.hide()
			
			$five2six.hide()
			
			$six2seven.hide()
			
			$seven2eight.show()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.show()
			
			$six2five.hide()
			
			$five2four.hide()
			
			$four2three.hide()
			
			$three2two.hide()
			
			$two2one.hide()
			
		"seven2six":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.hide()
			
			$four2five.hide()
			
			$five2six.hide()
			
			$six2seven.show()
			
			$seven2eight.hide()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.hide()
			
			$six2five.show()
			
			$five2four.hide()
			
			$four2three.hide()
			
			$three2two.hide()
			
			$two2one.hide()
			
		"six2five":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.hide()
			
			$four2five.hide()
			
			$five2six.show()
			
			$six2seven.hide()
			
			$seven2eight.hide()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.hide()
			
			$six2five.hide()
			
			$five2four.show()
			
			$four2three.hide()
			
			$three2two.hide()
			
			$two2one.hide()
			
		"five2four":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.hide()
			
			$four2five.show()
			
			$five2six.hide()
			
			$six2seven.hide()
			
			$seven2eight.hide()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.hide()
			
			$six2five.hide()
			
			$five2four.hide()
			
			$four2three.show()
			
			$three2two.hide()
			
			$two2one.hide()
			
		"four2three":
			
			$one2two.hide()
			
			$two2three.hide()
			
			$three2four.show()
			
			$four2five.hide()
			
			$five2six.hide()
			
			$six2seven.hide()
			
			$seven2eight.hide()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.hide()
			
			$six2five.hide()
			
			$five2four.hide()
			
			$four2three.hide()
			
			$three2two.show()
			
			$two2one.hide()
			
		"three2two":
			
			$one2two.hide()
			
			$two2three.show()
			
			$three2four.hide()
			
			$four2five.hide()
			
			$five2six.hide()
			
			$six2seven.hide()
			
			$seven2eight.hide()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.hide()
			
			$six2five.hide()
			
			$five2four.hide()
			
			$four2three.hide()
			
			$three2two.hide()
			
			$two2one.show()
			
		"two2one":
			
			$one2two.show()
			
			$two2three.hide()
			
			$three2four.hide()
			
			$four2five.hide()
			
			$five2six.hide()
			
			$six2seven.hide()
			
			$seven2eight.hide()
			
			$eight2nine.hide()
			
			$nine2eight.hide()
			
			$eight2seven.hide()
			
			$seven2six.hide()
			
			$six2five.hide()
			
			$five2four.hide()
			
			$four2three.hide()
			
			$three2two.hide()
			
			$two2one.hide()
