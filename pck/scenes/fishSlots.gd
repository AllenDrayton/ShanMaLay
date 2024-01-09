extends Node2D

var slots = []

var balance

func _ready():
	loadTextures()
	request_http()
	if Signals.user_mute_music == true:
		Config.MUSIC.volume_db = -80
	elif Signals.user_mute_music == false:
		Config.MUSIC.volume_db = 0

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
	print("Name: ",slotName)
	print("Key: ",accessKey)
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
	print(json_result)
	Config.slot_url = json_result["url"]
	OS.shell_open(Config.slot_url)
#	LoadingScript.load_scene(self,"res://CEF.tscn")


func _on_Back_pressed():
	Config.MUSIC.volume_db = -80
	LoadingScript.load_scene(self,"res://pck/scenes/menu.tscn")
