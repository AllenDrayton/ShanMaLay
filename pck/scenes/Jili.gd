extends Node

# This is JILI Script
var balance

var slot_textures=[]
var filepath="res://pck/assets/slot/slot-game-AWC(KINGMAKER).json"
var acesskey
var game_name

func _load_profile_textures():
	for i in range(29):
		var path = "res://pck/assets/slot/Jili/B" + str(i+1) + ".png"
		var texture = load(path)
		slot_textures.append(texture) 

func _ready():
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
	var buttons = $provider/p.get_children()
	
	for i in range(buttons.size()):
		var button = buttons[i]
		if button is TextureButton:
			button.texture_normal =slot_textures[i]


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



func _on_Exit_pressed():
	
	# For Music
	$"/root/bgm".volume_db = -50
	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")

func _on_game_pressed(game_name,accesskey):
	
	# For Music
	$"/root/bgm".volume_db = -50
	
	print(game_name,",",accesskey)
	
	var postman_url = "http://redboxmm.tech:8081/acrf-qarava-slot/api/slotplayconnect/getplaylink"
	
	var data = {
	"accesskey": "",
	"gameProvider": "awc(jili)",
	"lang": "en",
	"game": accesskey,
	"gameName": accesskey,
	"isMobile": Config.config["web"]["isMobile"],
	"redirectLink": "",
	"type": Config.config["web"]["type"],
	"name": "",
	"session": "",
	"provider": "skme-mclub",
#	"username": $"/root/Config".config.user.username,
	"username":"mk0000640",
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
	OS.shell_open(Config.slot_url)

