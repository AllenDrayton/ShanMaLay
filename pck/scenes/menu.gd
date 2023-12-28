extends Node2D

const profile_textures = []
const music = preload("res://pck/assets/audio/music-1.mp3")

# Constants for timeout
var http

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Reset The Music
	#$"/root/bgm".volume_db = $Setting/SliderMusic.value
	
	if $Setting/SliderMusic.value == 0:
		$"/root/bgm".volume_db =  $Setting/SliderMusic.value
	else:
		$"/root/bgm".volume_db += 45
	
	_load_profile_textures()
	$AnimationPlayer.play("in")
	$ButtonAnimation.play("in")
	$UpperPanelAnimation.play("in")
	var request = {
		"head":"user info"
	}
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	http = HTTPRequest.new()
	add_child(http)
	http.timeout = 3
	http.connect("request_completed",self,"_update_info")
	http.request(url)
	
	var currentMusic = $"/root/bgm".stream.resource_path.get_file().get_basename()
	if currentMusic != "music-1":
		$"/root/bgm".stream = music
		$"/root/bgm".play()


func _update_info(result, response_code, headers, body):
	print("This is Menu Respond code : ", response_code)
	if response_code != 200:
		$"/root/bgm".volume_db = -50
		LoadingScript.load_scene(self, "res://start/conn_error.tscn")
	else:
		var json_parse_result = JSON.parse(body.get_string_from_utf8())
		if json_parse_result.error != OK:
			print("Error: JSON parsing failed -", json_parse_result.error)
		else:
			var respond = json_parse_result.result
			#var respond = JSON.parse(body.get_string_from_utf8()).result
			$MoneyBg/Balance.text = comma_sep(respond.balance)
			$ProfileBg/Username.text = respond.username
			$ProfileBg/Nickname.text = respond.nickname
			$ProfileBg/Profile.texture_normal = profile_textures[int(respond.profile)]


func _load_profile_textures():
	for i in range(13):
		var path = "res://pck/assets/common/profiles/" + str(i) + ".png"
		var texture = load(path)
		profile_textures.append(texture) 


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		$AnimationPlayer.play("out")
		$ButtonAnimation.play("out")
		$UpperPanelAnimation.play("out")
		yield(get_tree().create_timer(0.6), "timeout")
		get_tree().change_scene("res://pck/scenes/confirm_exit.tscn")


func comma_sep(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]

	return res


func _on_Profile_pressed():
	
	# For Music
	$"/root/bgm".volume_db = -45
	
	$AnimationPlayer.play("out")
	$ButtonAnimation.play("out")
	$UpperPanelAnimation.play("out")
	yield(get_tree().create_timer(0.6), "timeout")
	get_tree().change_scene("res://pck/scenes/profile_setting.tscn")


func _on_SettingToggle_pressed():
	$Setting._show()


func _on_ShanKoeMee_pressed():
	$"/root/bgm".volume_db = -45
	$AnimationPlayer.play("out")
	$ButtonAnimation.play("out")
	$UpperPanelAnimation.play("out")
	yield(get_tree().create_timer(0.6), "timeout")
	get_tree().change_scene("res://pck/scenes/shankoemee_level.tscn")


func _on_BuGyee_pressed():
	$"/root/bgm".volume_db = -45
	$AnimationPlayer.play("out")
	$ButtonAnimation.play("out")
	$UpperPanelAnimation.play("out")
	yield(get_tree().create_timer(0.6), "timeout")
	get_tree().change_scene("res://pck/scenes/bugyee_level.tscn")


func _on_Bet_pressed():
	$"/root/bgm".volume_db = -45
	$AnimationPlayer.play("out")
	$ButtonAnimation.play("out")
	$UpperPanelAnimation.play("out")
	yield(get_tree().create_timer(0.6), "timeout")
	get_tree().change_scene("res://pck/scenes/bet_game.tscn")


func _on_ShweShan_pressed():
	$"/root/bgm".volume_db = -45
	$AnimationPlayer.play("out")
	$ButtonAnimation.play("out")
	$UpperPanelAnimation.play("out")
	yield(get_tree().create_timer(0.6), "timeout")
	get_tree().change_scene("res://pck/scenes/shwe_shan_level.tscn")


func _on_Poker_pressed():
	$"/root/bgm".volume_db = -45
	$AnimationPlayer.play("out")
	$ButtonAnimation.play("out")
	$UpperPanelAnimation.play("out")
	yield(get_tree().create_timer(0.6), "timeout")
	get_tree().change_scene("res://pck/scenes/poker_level.tscn")


func _on_Viber_pressed():
	OS.shell_open("viber://chat/?number=%2B959266714552")


func _on_Slot_pressed():
	$"/root/bgm".volume_db = -45
	var username = $"/root/Config".config.user.username
	var session = $"/root/Config".config.user.session
	#OS.shell_open("https://shanmalay-slots-client.vercel.app/?uD="+str(username)+"&sD="+str(session))
	$SlotControl.show()
	load_web_page("https://shanmalay-slots-client.vercel.app/?uD="+str(username)+"&sD="+str(session))

func load_web_page(url: String):
	var iframe_code = "<iframe src=\"" + url + "\" width=\"100%\" height=\"100%\"></iframe>"
	$SlotControl/WebViewContainer.set("custom_html", iframe_code)
