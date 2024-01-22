extends Node

var slot_textures=[]

func _load_profile_textures():
	for i in range(5):
		var path = "res://pck/assets/slot/slot_provider/A" + str(i+1) + ".png"
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
	http.timeout = 3
	http.connect("request_completed",self,"_update_info")
	http.request(url)
	_load_profile_textures()
	var buttons = $p.get_children()
	
	for i in range(buttons.size()):
		var button = buttons[i]
		if button is TextureButton:
			button.texture_normal =slot_textures[i]
	
func _update_info(result, response_code, headers, body):
	print("This is Slot Provider Respond code : ", response_code)
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
			$Balance/Label.text = comma_sep(respond.balance)
	
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_Exit_pressed()


func comma_sep(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]

	return res
	
func _on_Exit_pressed():
	
	# For Music
	$"/root/bgm".volume_db = -50
	LoadingScript.load_scene(self, "res://pck/scenes/menu.tscn")


func _on_provider_pressed(provider_name):
	$"/root/bgm".volume_db = -50
	LoadingScript.load_scene(self, "res://pck/scenes/"+provider_name+".tscn")
