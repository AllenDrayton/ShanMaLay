extends Node2D

onready var slotsPlaceholder = preload("res://pck/assets/menu/slot.png")
onready var texture = preload("res://pck/assets/slot/PG/fruity candy.png")

export var websocket_url = "ws://redboxmm.tech:8081/acrf-qarava-slot/slotplaysocket"

var _client = WebSocketClient.new()
var balance = 0
var canPress = true
var Slot_Page = 1

onready var slotContainers = [
	$Slot_container1/p,
	$Slot_container2/p,
	$Slot_container3/p,
	$Slot_container4/p,
	$Slot_container5/p,
	$Slot_container6/p,
	$Slot_container7/p,
	$Slot_container8/p,
	$Slot_container9/p,
	$Slot_container10/p,
]

var PGLIST = {
	# 0 - 10
	"Honey Trap of Diao Chan": ["1", preload("res://pck/assets/slot/PG/HoneyTrapofDiaoChan.png")],
	"Candy Bonanza": ["100", preload("res://pck/assets/slot/PG/candy-bonanza.png")],
	"Rise of Apollo": ["101", preload("res://pck/assets/slot/PG/rise-of-apollo.png")],
	"Mermaid Riches": ["102", preload("res://pck/assets/slot/PG/mermaid-riches.png")],
	"Crypto Gold": ["103", preload("res://pck/assets/slot/PG/crypto-gold.png")],
	"Wild Bandito": ["104", preload("res://pck/assets/slot/PG/wild bantido.png")],
	"Heist Stakes": ["105", preload("res://pck/assets/slot/PG/heist of stakes.png")],
	"Ways of the Qilin": ["106", preload("res://pck/assets/slot/PG/ways of qilin.png")],
	"Legendary Monkey King": ["107", preload("res://pck/assets/slot/PG/legendary-monkey-king.png")],
	"Buffalo Win": ["108", preload("res://pck/assets/slot/PG/bufallo-win.png")],
	# 10 - 20
	"Jurassic Kingdom": ["110", preload("res://pck/assets/slot/PG/jurassic-kingdom.png")],
	"Oriental Prosperity": ["112", preload("res://pck/assets/slot/PG/oriental-prosperity.png")],
	"Raider Jane's Crypt of Fortune": ["113", preload("res://pck/assets/slot/PG/raider-jane-crypt-of-fortune.png")],
	"Emoji Riches": ["114", preload("res://pck/assets/slot/PG/emoji-riches.png")],
	"Supermarket Spree": ["115", preload("res://pck/assets/slot/PG/supermarket-spree_appicon_square.png")],
#	"Farm Invaders": ["116", preload("res://pck/assets/slot/PG/farm-invaders.png")],
	"Cocktail Nights": ["117", preload("res://pck/assets/slot/PG/cocktail-nights.png")],
	"Mask Carnival": ["118", preload("res://pck/assets/slot/PG/mask-carnival.png")],
	"Spirited Wonders": ["119", preload("res://pck/assets/slot/PG/spirited-wonders.png")],
	"Destiny of Sun & Moon": ["121", preload("res://pck/assets/slot/PG/the destiny of sun and moon.png")],
	# 20 - 30
	"Garuda Gems": ["122", preload("res://pck/assets/slot/PG/Garuda Gems.png")],
	"Rooster Rumble": ["123", preload("res://pck/assets/slot/PG/rooster-rumble.png")],
	"Butterfly Blossom": ["125", preload("res://pck/assets/slot/PG/butterfly blossom.png")],
	"Fortune Tiger": ["126", preload("res://pck/assets/slot/PG/fortune tiger.png")],
	"The Queen's Banquet": ["127", preload("res://pck/assets/slot/PG/the queens banquet.png")],
	"Battleground Royale": ["128", preload("res://pck/assets/slot/PG/battleground royale.png")],
	"Win Win Fish Prawn": ["129", preload("res://pck/assets/slot/PG/win win fish prawn.png")],
	"Lucky Piggy": ["130", preload("res://pck/assets/slot/PG/Lucky Piggy.png")],
	"Speed Winner": ["131", preload("res://pck/assets/slot/PG/Speed Winner.png")],
	"Legend of Perseus": ["132", preload("res://pck/assets/slot/PG/legend-of-perseus.png")],
	# 30 - 40
	"Wild Coaster": ["133", preload("res://pck/assets/slot/PG/wild-coastern.png")],
#	"Wizdom Wonders": ["17", preload("res://pck/assets/slot/PG/WizdomWonders.png")],
	"Hood vs Wolf": ["18", preload("res://pck/assets/slot/PG/hood vs wolf.png")],
	"Gem Saviour": ["2", preload("res://pck/assets/slot/PG/gemsavour conquest].png")],
	"Reel Love": ["20", preload("res://pck/assets/slot/PG/reel-love.png")],
	"Win Win Won": ["24", preload("res://pck/assets/slot/PG/win win won.png")],
	"Plushie Frenzy": ["25", preload("res://pck/assets/slot/PG/PlushieFrenzy.png")],
	"Tree of Fortune": ["26", preload("res://pck/assets/slot/PG/TreeofFortune.png")],
	"Hotpot": ["28", preload("res://pck/assets/slot/PG/hotpot.png")],
	"Dragon Legend": ["29", preload("res://pck/assets/slot/PG/dragon legend.png")],
	# 40 - 50
	"Fortune Gods": ["3", preload("res://pck/assets/slot/PG/fortune gods.png")],
#	"Baccarat Deluxe": ["31", preload("res://pck/assets/slot/PG/BaccaratDeluxe.png")],
	"Hip Hop Panda": ["33", preload("res://pck/assets/slot/PG/hip hop panda.png")],
	"Legend of Hou Yi": ["34", preload("res://pck/assets/slot/PG/legend of hau yi.png")],
	"Mr. Hallow-Win": ["35", preload("res://pck/assets/slot/PG/mr. halloween.png")],
	"Prosperity Lion": ["36", preload("res://pck/assets/slot/PG/prospertiy lion.png")],
	"Santa's Gift Rush": ["37", preload("res://pck/assets/slot/PG/santa\'s gift.png")],
	"Gem Saviour Sword": ["38", preload("res://pck/assets/slot/PG/GemSaviourSword.png")],
	"Jungle Delight": ["40", preload("res://pck/assets/slot/PG/JungleDelight_.png")],
	"Symbols of Egypt": ["41", preload("res://pck/assets/slot/PG/symbols of egypt.png")],
	# 50 - 60
	"Ganesha Gold": ["42", preload("res://pck/assets/slot/PG/GaneshaGold.png")],
#	"Three Monkeys": ["43", preload("res://pck/assets/slot/PG/3Monkeys.png")],
	"Emperor's Favour": ["44", preload("res://pck/assets/slot/PG/EmperorsFavour.png")],
	"Double Fortune": ["48", preload("res://pck/assets/slot/PG/48.png")],
	"Journey to the Wealth": ["50", preload("res://pck/assets/slot/PG/journey to the wealth.png")],
	"The Great Icescape": ["53", preload("res://pck/assets/slot/PG/the great icesceape.png")],
	"Captain's Bounty": ["54", preload("res://pck/assets/slot/PG/captain bounty.png")],
	"Dragon Hatch": ["57", preload("res://pck/assets/slot/PG/dragon hatch.png")],
	"Vampire's Charm": ["58", preload("res://pck/assets/slot/PG/vampire charm.png")],
	"Ninja vs Samurai": ["59", preload("res://pck/assets/slot/PG/NinjavsSamurai.png")],
	# 60 - 70
	"Medusa": ["6", preload("res://pck/assets/slot/PG/medusa 1.png")],
	"Leprechaun Riches": ["60", preload("res://pck/assets/slot/PG/leprachun.png")],
	"Flirting Scholar": ["61", preload("res://pck/assets/slot/PG/FlirtingScholar.png")],
	"Gem Saviour Conquest": ["62", preload("res://pck/assets/slot/PG/gemsavour conquest].png")],
	"Dragon Tiger Luck": ["63", preload("res://pck/assets/slot/PG/dragon-tiger-luck.png")],
	"Muay Thai Champion": ["64", preload("res://pck/assets/slot/PG/mhwy thai.png")],
	"Mahjong Ways": ["65", preload("res://pck/assets/slot/PG/majhong ways.png")],
	"Shaolin Soccer": ["67", preload("res://pck/assets/slot/PG/shaolin-soccer.png")],
	"Fortune Mouse": ["68", preload("res://pck/assets/slot/PG/fortune-mouse.png")],
	"Bikini Paradise": ["69", preload("res://pck/assets/slot/PG/bikini-paradise.png")],
	# 70 - 80
	"Medusa II": ["7", preload("res://pck/assets/slot/PG/medusa 2.png")],
	"Candy Burst": ["70", preload("res://pck/assets/slot/PG/candy-burst.png")],
	"Caishen Wins": ["71", preload("res://pck/assets/slot/PG/caishen win.png")],
	"Egypt's Book of Mystery": ["73", preload("res://pck/assets/slot/PG/egypt book of mysteruy.png")],
	"Mahjong Ways 2": ["74", preload("res://pck/assets/slot/PG/mahjong-ways2.png")],
	"Ganesha Fortune": ["75", preload("res://pck/assets/slot/PG/genesha fortune.png")],
	"Dreams of Macau": ["79", preload("res://pck/assets/slot/PG/dreams of macau.png")],
	"Circus Delight": ["80", preload("res://pck/assets/slot/PG/circus-delight.png")],
	"Phoenix Rises": ["82", preload("res://pck/assets/slot/PG/phoenix-rises.png")],
	"Wild Fireworks": ["83", preload("res://pck/assets/slot/PG/wild-fireworks.png")],
	# 80 - 90
	"Queen of Bounty": ["84", preload("res://pck/assets/slot/PG/queen of bounty.png")],
	"Genie's 3 Wishes": ["85", preload("res://pck/assets/slot/PG/genie\'s 3 wishes.png")],
	"Galactic Gems": ["86", preload("res://pck/assets/slot/PG/galactic-gems.png")],
	"Treasures of Aztec": ["87", preload("res://pck/assets/slot/PG/treasure of azetch.png")],
	"Jewels of Prosperity": ["88", preload("res://pck/assets/slot/PG/jewels of prospertiy.png")],
	"Lucky Neko": ["89", preload("res://pck/assets/slot/PG/lucky-neko.png")],
	"Secret of Cleopatra": ["90", preload("res://pck/assets/slot/PG/secrets of cleopatra.png")],
	"Guardians of Ice and Fire": ["91", preload("res://pck/assets/slot/PG/guardian of ice and fire.png")],
	"Thai River Wonders": ["92", preload("res://pck/assets/slot/PG/thai-river-wonders.png")],
	"Opera Dynasty": ["93", preload("res://pck/assets/slot/PG/opera-dynasty.png")],
	# 90 - 100
	"Bali Vacation": ["94", preload("res://pck/assets/slot/PG/bali-vacation.png")],
	"Majestic Treasures": ["95", preload("res://pck/assets/slot/PG/majestic treaurse.png")],
	"Jack Frost's Winter": ["97", preload("res://pck/assets/slot/PG/jaskfrost winter.png")],
	"Fortune Ox": ["98", preload("res://pck/assets/slot/PG/fortune ox.png")],
}

			
# Called when the node enters the scene tree for the first time.
func _ready():
	# For Slot Slider Buttons
# warning-ignore:return_value_discarded
	$animationControlButtons/Right/RightButton.connect("pressed", self, "Right_Button_Pressed", [Slot_Page])
# warning-ignore:return_value_discarded
	$animationControlButtons/Left/LeftButton.connect("pressed", self, "Left_Button_Pressed", [Slot_Page])
	
	$Backdrop.show()
	_disabled_buttons()
	
	$PGAnimation.play("RESET")
	$animationControlButtons/Left/LeftButton.hide()
	
	var keys_array = PGLIST.keys()
	# slot 1
	var slot1 = $Slot_container1/p.get_children()
	var count1 = 0
	for i in range(0, min(10, keys_array.size())): # 0 - 10
		var slot = slot1[count1]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = PGLIST[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count1 += 1
	# slot 2
	var slot2 = $Slot_container2/p.get_children()
	var count2 = 0
	for i in range(10, min(20, keys_array.size())): # 10 - 20
		var slot = slot2[count2]  
		var key = keys_array[i]
		var name = key
		if key == "Medusa 1: the Curse of Athena":
			key = "Medusa 1 the Curse of Athena"
		elif key == "Medusa 2: the Quest of Perseus":
			key = "Medusa 2 the Quest of Perseus"
		elif key == "Mr. Hallow-Win!":
			key = "Mr Hallow-Win!"
		slot.set_name(str(key))
		slot.texture_normal = PGLIST[name][1]
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
		slot.texture_normal = PGLIST[name][1]
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
		slot.texture_normal = PGLIST[name][1]
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
		slot.texture_normal = PGLIST[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count5 += 1
	
	# slot 6
	var slot6 = $Slot_container6/p.get_children()
	var count6 = 0
	for i in range(50, min(60, keys_array.size())): # 50 - 60
		var slot = slot6[count6]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = PGLIST[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count6 += 1
	
	# slot 7
	var slot7 = $Slot_container7/p.get_children()
	var count7 = 0
	for i in range(60, min(70, keys_array.size())): # 60 - 70
		var slot = slot7[count7]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = PGLIST[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count7 += 1

	# slot 8
	var slot8 = $Slot_container8/p.get_children()
	var count8 = 0
	for i in range(70, min(80, keys_array.size())): # 70 - 80
		var slot = slot8[count8]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		print(name)
		slot.texture_normal = PGLIST[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count8 += 1
	
	# slot 9 
	var slot9 = $Slot_container9/p.get_children()
	var count9 = 0
	for i in range(80, min(90, keys_array.size())): # 80 - 90
		var slot = slot9[count9]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = PGLIST[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count9 += 1
		
	# slot 10
	var slot10 = $Slot_container10/p.get_children()
	var count10 = 0
	for i in range(90, min(100, keys_array.size())): # 90 - 100
		var slot = slot10[count10]  
		var key = keys_array[i]
		var name = key
		slot.set_name(str(key))
		slot.texture_normal = PGLIST[name][1]
		slot.connect("pressed", self, "_on_slot_pressed", [slot])
		count10 += 1
		
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
		

func Right_Button_Pressed(slot_page_no):
	if canPress == true:
		canPress = false
		if slot_page_no != Slot_Page:
			slot_page_no = Slot_Page
		var page = str(int(slot_page_no),"to",int(slot_page_no + 1))
		print("Animation: ",page)
		$PGAnimation.play(page)
		$Cooldown.start()
		Slot_Page += 1
	
func Left_Button_Pressed(slot_page_no):
	if canPress == true:
		canPress = false
		if slot_page_no != Slot_Page:
			slot_page_no = Slot_Page
		var page = str(int(slot_page_no),"to",int(slot_page_no - 1))
		print("Animation: ",page)
		$PGAnimation.play(page)
		$Cooldown.start()
		Slot_Page -= 1

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
	elif button.name == "Mr Hallow-Win":
		name = "Mr. Hallow-Win"
	elif button.name == "@Egypt's Book of Mystery@12":
		name = "Egypt's Book of Mystery"
	var accesskey = PGLIST[name][0]
	print(name,": ",accesskey)
	
#	var postman_url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotplayconnect/getplaylink"
	var postman_url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotplayconnect/getgamelink"

	var data = {
	"accesskey": "",
	"gameProvider": "PGSlot",
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


func _on_PGAnimation_animation_finished(anim_name):
	match anim_name:
#		"9to10":
#			$animationControlButtons/Right/RightButton.hide()
		"8to9":
			$animationControlButtons/Right/RightButton.hide()
			
		"2to1":
			$animationControlButtons/Left/LeftButton.hide()
			
		"1to2":
			$animationControlButtons/Left/LeftButton.show()
			
#		"10to9":
#			$animationControlButtons/Right/RightButton.show()
		"9to8":
			$animationControlButtons/Right/RightButton.show()

func _on_Exit_pressed():
	$Timer.start()


func _on_Timer_timeout():
	# For Music
	$"/root/bgm".volume_db = -50
	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")


func _on_Websocket_timer_timeout():
	$"/root/bgm".volume_db = -50
	$Backdrop.hide()
	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")


func _on_Cooldown_timeout():
	canPress = true
