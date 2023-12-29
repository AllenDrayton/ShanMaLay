extends Node
var slot_textures=[]
#var filepath = ""
var acesskey
var game_name

func _load_profile_textures():
	for i in range(22):
		var path = "res://pck/assets/slot/pragmatic/" + str(i+1) + ".png"
		var texture = load(path)
		slot_textures.append(texture) 

func _ready():
	if $Setting/SliderMusic.value == 0:
		$"/root/bgm".volume_db =  $Setting/SliderMusic.value
	else:
		$"/root/bgm".volume_db += 45
	
#	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
#	var http = HTTPRequest.new()
#	add_child(http)
#	http.connect("request_completed",self,"_update_info")
#	http.request(url)
#	for i in $provider/p.get_children():
#		i.texure_normal = null
	_load_profile_textures()
	var buttons = $provider/p.get_children()
	
	for i in range(buttons.size()):
		var button = buttons[i]
		if button is TextureButton:
			button.texture_normal =slot_textures[i]

func _on_Exit_pressed():
	
	# For Music
	$"/root/bgm".volume_db = -50
	LoadingScript.load_scene(self,"res://pck/scenes/slot_provider.tscn")

func _on_game_pressed(game_name,accesskey):
	print(game_name,",",accesskey)
#	var data = {
#		"name":name,
#		"accesskey":acesskey,
#	}
#	var url = $"/root/Config".config.account_url + "profile_change"
#	var http = HTTPRequest.new()
#	add_child(http)
#	http.connect("request_completed",self,"_game_entered")
#	var headers = ["Content-Type: application/json"]
#	var body = JSON.print(data)
#	http.request(url,headers,false,HTTPClient.METHOD_POST,body)
#	print(game_name,",",accesskey,"request sent")
#
#func _game_entered():
#	print("game_enter")

