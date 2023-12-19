extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Reset The Music
	#$"/root/bgm".volume_db = $Setting/SliderMusic.value
	
	if $Setting/SliderMusic.value == 0:
		$"/root/bgm".volume_db =  $Setting/SliderMusic.value
	else:
		$"/root/bgm".volume_db += 45
	
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_update_info")
	http.request(url)
	$UpperPanelAnimation.play("in")


func _update_info(result, response_code, headers, body):
	var respond = JSON.parse(body.get_string_from_utf8()).result
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

func _on_Exit_pressed():
	
	# For Music
	$"/root/bgm".volume_db = -50
	
	$UpperPanelAnimation.play("out")
	yield(get_tree().create_timer(0.5), "timeout")
	#get_tree().change_scene("res://pck/scenes/menu.tscn")
	LoadingScript.load_scene(self, "res://pck/scenes/menu.tscn")

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_Exit_pressed()

func _on_SKM_pressed():
	
	# For Music
	$"/root/bgm".volume_db = -50
	
	$AnimatedSprite.show()
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play("playing")
#	var data = {
#		"username":$"/root/Config".config.user.username,
#		"session":$"/root/Config".config.user.session
#	}
#	var url = $"/root/Config".config.account_url + "skm_bet"
#	var http = HTTPRequest.new()
#	add_child(http)
#	http.connect("request_completed",self,"_on_skm_respond")
#	var headers = ["Content-Type: application/json"]
#	var body = JSON.print(data)
#	http.request(url,headers,false,HTTPClient.METHOD_POST,body)

func _on_skm_respond(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var res = json.result;
	print(res)
	if res.status == "ok":
		$"/root/Config".config.gameState = {
			"passcode":res.passcode,
			"url":res.url
		}
		#get_tree().change_scene("res://pck/scenes/skm_bet_game.tscn")
		LoadingScript.load_scene(self, "res://pck/scenes/skm_bet_game.tscn")
		

func _on_HorseRacing_pressed():
	
	# For Music
	$"/root/bgm".volume_db = -50
	
	$AnimatedSprite2.show()
	$AnimatedSprite2.frame = 0
	$AnimatedSprite2.play("playing")
#	var data = {
#		"username":$"/root/Config".config.user.username,
#		"session":$"/root/Config".config.user.session
#	}
#	var url = $"/root/Config".config.account_url + "horse_bet"
#	var http = HTTPRequest.new()
#	add_child(http)
#	http.connect("request_completed",self,"_on_HorseRacing_respond")
#	var headers = ["Content-Type: application/json"]
#	var body = JSON.print(data)
#	http.request(url,headers,false,HTTPClient.METHOD_POST,body)

func _on_HorseRacing_respond(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var res = json.result;
	print(res)
	if res.status == "ok":
		$"/root/Config".config.gameState = {
			"passcode":res.passcode,
			"url":res.url
		}
		#get_tree().change_scene("res://pck/scenes/horse_bet_game.tscn")
		LoadingScript.load_scene(self, "res://pck/scenes/horse_bet_game.tscn")

func _on_TigerDragon_pressed():
	# For Music
	$"/root/bgm".volume_db = -50
	
	$AnimatedSprite3.show()
	$AnimatedSprite3.frame = 0
	$AnimatedSprite3.play("playing")
#	var data = {
#		"username":$"/root/Config".config.user.username,
#		"session":$"/root/Config".config.user.session
#	}
#	var url = $"/root/Config".config.account_url + "dragon_tiger_bet"
#	var http = HTTPRequest.new()
#	add_child(http)
#	http.connect("request_completed",self,"_on_dragon_tiger_respond")
#	var headers = ["Content-Type: application/json"]
#	var body = JSON.print(data)
#	http.request(url,headers,false,HTTPClient.METHOD_POST,body)

func _on_dragon_tiger_respond(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var res = json.result;
	print(res)
	if res.status == "ok":
		$"/root/Config".config.gameState = {
			"passcode":res.passcode,
			"url":res.url
		}
		
		#get_tree().change_scene("res://pck/scenes/tiger_dragon_bet_game.tscn")
		LoadingScript.load_scene(self, "res://pck/scenes/tiger_dragon_bet_game.tscn")


func _on_AnimatedSprite_animation_finished():
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


func _on_AnimatedSprite2_animation_finished():
	var data = {
		"username":$"/root/Config".config.user.username,
		"session":$"/root/Config".config.user.session
	}
	var url = $"/root/Config".config.account_url + "horse_bet"
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_on_HorseRacing_respond")
	var headers = ["Content-Type: application/json"]
	var body = JSON.print(data)
	http.request(url,headers,false,HTTPClient.METHOD_POST,body)


func _on_AnimatedSprite3_animation_finished():
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
