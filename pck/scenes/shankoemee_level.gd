extends Node2D

const music = preload("res://pck/assets/audio/music-main-background.mp3")
const BlankMusic = preload("res://pck/assets/shankoemee/audio/EmptySound.ogg")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Exit.disabled = false
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_update_info")
	http.request(url)
	$AnimationPlayer.play("in")
	#Config.MUSIC.stream = music
	#Config.MUSIC.play()

#	$"/root/bgm".volume_db = 0
	
	if Signals.user_mute_music == true:
		Config.MUSIC.volume_db = -80
	elif Signals.user_mute_music == false:
		Config.MUSIC.volume_db = 0



# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _update_info(result, response_code, headers, body):
	var respond = JSON.parse(body.get_string_from_utf8()).result
	$Label.text = comma_sep(respond.balance)


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


func _on_level_pressed(level):
	#Config.MUSIC.stream = BlankMusic
	Config.MUSIC.volume_db = -80
	var data = {
		"username":$"/root/Config".config.user.username,
		"session":$"/root/Config".config.user.session,
		"level":level
	}
	var url = $"/root/Config".config.account_url + "shankoemee"
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_level_selected")
	var headers = ["Content-Type: application/json"]
	var body = JSON.print(data)
	http.request(url,headers,false,HTTPClient.METHOD_POST,body)


# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _level_selected(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var res = json.result;
	print(res)
	if res.status == "ok":
		$"/root/Config".config.gameState = {
			"passcode":res.passcode,
			"url":res.url
		}
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://pck/scenes/shankoemee_game.tscn")
	elif res.status == "not enough balance":
		$AlertBox._show("အခန္းထဲဝင္ရန္ပိုက္ဆံမလုံေလာက္ပါ။")
	elif res.status == "too much balance":
		$AlertBox._show("အခန္းထဲဝင္ရန္ပိုက္ဆံမ်ားေနပါသည္။")
	elif res.status == "player already exist":
		$AlertBox._show("Player already exist")
	elif res.status == "not active":
		$AlertBox._show("ShanKoeMee server in maintenance please come back later")


func _on_Exit_pressed():
	$Exit.disabled = true
	Config.MUSIC.volume_db = -80
	$AnimationPlayer.play("out")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "out":
#		get_tree().change_scene("res://pck/scenes/menu.tscn")
		LoadingScript.load_scene(self, "res://pck/scenes/menu.tscn")
