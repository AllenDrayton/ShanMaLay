extends Control

const profile_textures = []

const music = preload("res://pck/assets/audio/music-main-background.mp3")
const BlankMusic = preload("res://pck/assets/shankoemee/audio/EmptySound.ogg")

# Called when the node enters the scene tree for the first time.


func _ready():
	print("Config:",Config.config)
	if Signals.user_mute_music == true:
		Config.MUSIC.volume_db = -80
	elif Signals.user_mute_music == false:
		Config.MUSIC.volume_db = 0
	
# warning-ignore:return_value_discarded
	Signals.connect("disableButtons",self,"on_disable_buttons")
	
#	$ABCD.modulate = Color(0.5, 0.5, 0.5, 0.8)
#	$Fishing/FishSprite.modulate = Color(0.5, 0.5, 0.5, 0.8)
#	$Slots/SlotSprite.modulate = Color(0.5, 0.5, 0.5, 0.8)
#	$BuGyee/BuGyee_GIF.modulate = Color(0.5, 0.5, 0.5, 0.8)

	_load_profile_textures()
	_animationIn()
# warning-ignore:return_value_discarded
	Config.connect("usernameUpdate",self,"_on_usernameUpdate")

# warning-ignore:unused_variable
	var request = {
		"head":"user info"
	}
	
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_update_info")
	http.request(url)
	var currentMusic = $"/root/bgm".stream.resource_path.get_file().get_basename()
	if currentMusic != "music-main-background":
		Config.MUSIC.stream = music
		Config.MUSIC.play()
# warning-ignore:return_value_discarded
	Signals.connect("profileChanged",self,"_on_profile_changed")

func _on_MenuMusic(data):
	print(data)

func on_disable_buttons():
	_disable_buttons(true)

func musicOn():
	Config.MUSIC.volume_db = 0

func musicOff():
	Config.MUSIC.volume_db = -80

	
func _disable_buttons(disable):
	$ShanKoeMee.disabled = disable
	$BuGyee.disabled = disable
	$ABCD.disabled = disable
	$TigerDragon.disabled = disable
	$Fishing.disabled = disable
	$Slots.disabled = disable
	$Members.disabled = disable
	$bank_Transfer.disabled = disable
	$Bank_withdraw.disabled = disable
	
func _on_profile_changed(selected_texture):
	$Profile.texture_normal = selected_texture

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _update_info(result, response_code, headers, body):
	var respond = JSON.parse(body.get_string_from_utf8()).result
#	print(respond)
	$Balance.text = comma_sep(respond.balance)
	$Username.text = respond.username
	$Nickname.text = respond.nickname
	$Profile.texture_normal = profile_textures[int(respond.profile) - 1]


func _on_usernameUpdate(name):
	$Nickname.text = name

func _load_profile_textures():
	for i in range(26):
		var path = "res://pck/assets/HomeScence/Home-Photo/icon-photo-" + str(i+1) + ".png"
		var texture = load(path)
		profile_textures.append(texture)
#	print(profile_textures)


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		_animationOut()
		yield(get_tree().create_timer(0.5), "timeout")
# warning-ignore:return_value_discarded
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
	Config.MUSIC.volume_db = -80
# warning-ignore:return_value_discarded
	LoadingScript.load_scene(self,"res://pck/scenes/player_info.tscn")

func _on_SettingToggle_pressed():
	$Setting.show()

func _animationIn():
	$AnimationPlayer.play("in")
	$GamesOutAnimation.play("Games_in")
	$UpperbracketAnimation.play("in")
	$BottomBarAnimation.play("In ")
	
func _animationOut():
	$AnimationPlayer.play("out")
	$GamesOutAnimation.play("Games_out")
	$UpperbracketAnimation.play("out")
	$BottomBarAnimation.play("Out")

func _on_ShanKoeMee_pressed():
	#Config.MUSIC.stream = BlankMusic
	Config.MUSIC.volume_db = -80
	_animationOut()
	yield(get_tree().create_timer(0.5), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://pck/scenes/shankoemee_level.tscn")


func _on_BuGyee_pressed():
	#Config.MUSIC.stream = BlankMusic
	Config.MUSIC.volume_db = -80
	_animationOut()
	yield(get_tree().create_timer(0.5), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://pck/scenes/bugyee_level.tscn")


#func _on_Bet_pressed():
#	$AnimationPlayer.play("out")
#	yield(get_tree().create_timer(1), "timeout")
#	get_tree().change_scene("res://pck/scenes/bet_game.tscn")


func _on_ShweShan_pressed():
	_animationOut()
	yield(get_tree().create_timer(0.5), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://pck/scenes/shwe_shan_level.tscn")


func _on_Poker_pressed():
	_animationOut()
	yield(get_tree().create_timer(0.5), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://pck/scenes/poker_level.tscn")


func _on_Viber_pressed():
# warning-ignore:return_value_discarded
	OS.shell_open("viber://chat/?number=%2B959266714552")


func _on_Slots_pressed():
	Config.MUSIC.volume_db = -80
	LoadingScript.load_scene(self, "res://pck/scenes/slots.tscn")
	

func _on_TigerDragon_pressed():
	#Config.MUSIC.stream = BlankMusic
	Config.MUSIC.volume_db = -80
	var data = {
		"username":$"/root/Config".config.user.username,
		"session":$"/root/Config".config.user.session
	}
	var url = $"/root/Config".config.account_url + "dragon_tiger_bet"
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_on_dragon_tiger_respond")
	var headers = ["Content-Type: application/json"]
	var body = JSON.print(data)
	http.request(url,headers,false,HTTPClient.METHOD_POST,body)

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_dragon_tiger_respond(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var res = json.result
#	print(res)
	if res.status == "ok":
		$"/root/Config".config.gameState = {
			"passcode":res.passcode,
			"url":res.url
		}
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://pck/scenes/tiger_dragon_bet_game.tscn")


func _on_ABCD_pressed():
	#Config.MUSIC.stream = BlankMusic
	Config.MUSIC.volume_db = -80
	var data = {
		"username":$"/root/Config".config.user.username,
		"session":$"/root/Config".config.user.session
	}
	var url = $"/root/Config".config.account_url + "skm_bet"
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_on_skm_respond")
	var headers = ["Content-Type: application/json"]
	var body = JSON.print(data)
	http.request(url,headers,false,HTTPClient.METHOD_POST,body)

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_skm_respond(result, response_code, headers, body):
#	Signals.emit_signal("menuMusicOff")
	var json = JSON.parse(body.get_string_from_utf8())
	var res = json.result
#	print(res)
	if res.status == "ok":
		$"/root/Config".config.gameState = {
			"passcode":res.passcode,
			"url":res.url
		}
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://pck/scenes/skm_bet_game.tscn")

func _on_Members_pressed():
	Config.MUSIC.volume_db = -80
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://pck/scenes/info.tscn")

func _on_bank_Transfer_pressed():
	Config.MUSIC.volume_db = -80
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://pck/scenes/transfer.tscn")

func _on_Bank_withdraw_pressed():
	Config.MUSIC.volume_db = -80
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://pck/scenes/Withdraw.tscn")


func _on_Fishing_pressed():
	Config.MUSIC.volume_db = -80
	LoadingScript.load_scene(self,"res://pck/scenes/fishSlots.tscn") # Replace with function body.
