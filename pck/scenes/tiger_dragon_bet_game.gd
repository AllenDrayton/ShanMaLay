extends Node

var CARD_DELIVER_DELAY = 0.2

var max_length = 7

var betArr = [100,500,1000,2000,5000,10000]
var betArea = []
var betAmount = [0,0,0]
var myBetAmount = [0,0,0]
var myBetCoin = [0,0,0]
var bot = []
var botBalance = [0,0,0,0,0,0,0]
var fakeBet = false
var isExit = false
var wait = 1
var tick = 0
var websocket_url = ""
var selectedBet = 0
var cardPos = []
var profile_textures = []
var card_textures = {}
var t2 = 0
var timer = 0
var prev_selected=0

var _client = WebSocketClient.new()

var CardStatusVoices = [
	preload("res://pck/assets/skm_bet/audio/1.ogg"),
	preload("res://pck/assets/skm_bet/audio/2.ogg"),
	preload("res://pck/assets/skm_bet/audio/3.ogg"),
	preload("res://pck/assets/skm_bet/audio/4.ogg"),
	preload("res://pck/assets/skm_bet/audio/5.ogg"),
	preload("res://pck/assets/skm_bet/audio/6.ogg"),
	preload("res://pck/assets/skm_bet/audio/7.ogg"),
	preload("res://pck/assets/skm_bet/audio/8.ogg"),
	preload("res://pck/assets/skm_bet/audio/9.ogg"),
]

# Audio
var music = preload("res://pck/assets/dragon_tiger_bet/bg.ogg")
var GameVoices = {
	"exit":preload("res://pck/assets/common/audio/exit.ogg"),
	"new_game":preload("res://pck/assets/dragon_tiger_bet/tg_sa_pe_l_mal.ogg"),
	"stop_bet":preload("res://pck/assets/dragon_tiger_bet/tg_stop.ogg"),
	"dragon_win":preload("res://pck/assets/dragon_tiger_bet/d_.mp3"),
	"tiger_win":preload("res://pck/assets/dragon_tiger_bet/tg_tiger_voice.mp3"),
}

var coinPrefab = preload("res://pck/prefabs/Coin.tscn")
const cardPrefab = preload("res://pck/assets/skm_bet/Card.tscn")
var card_back = preload("res://pck/assets/common/cards/back.png")

const resultTextures = {
	"win":preload("res://pck/assets/shankoemee/win.png"),
	"lose":preload("res://pck/assets/shankoemee/lose.png")
}

var historyTextures = [
	preload("res://pck/assets/dragon_tiger_bet/icon_dragon.png"),
	preload("res://pck/assets/dragon_tiger_bet/icon_tie.png"),
	preload("res://pck/assets/dragon_tiger_bet/icon_tiger.png")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_profile_textures()
	$"/root/bgm".stream = music
	$"/root/bgm".play()
	
	# Reset Music
	#$"/root/bgm".volume_db = $Setting/SliderMusic.value
	
	if $Setting/SliderMusic.value == 0:
		$"/root/bgm".volume_db =  $Setting/SliderMusic.value
	else:
		$"/root/bgm".volume_db += 45
	
	for i in range(4):
		for j in range(1,10):
			var key = str(j) + str(i)
			var path = "res://pck/assets/common/cards/"+key+".png"
			card_textures[key] = load(path)
		var key1 = "D"+str(i)
		card_textures[key1] = load("res://pck/assets/common/cards/"+key1+".png")
		var key2 = "J"+str(i)
		card_textures[key2] = load("res://pck/assets/common/cards/"+key2+".png")
		var key3 = "Q"+str(i)
		card_textures[key3] = load("res://pck/assets/common/cards/"+key3+".png")
		var key4 = "K"+str(i)
		card_textures[key4] = load("res://pck/assets/common/cards/"+key4+".png")
	
	bot.append($Bots/Bot1)
	bot.append($Bots/Bot2)
	bot.append($Bots/Bot3)
	bot.append($Bots/Bot4)
	bot.append($Bots/Bot5)
	bot.append($Bots/Bot6)
	bot.append($Bots/Bot7)
	
	betArea.append($BetArea/Dragon)
	betArea.append($BetArea/Tie)
	betArea.append($BetArea/Tiger)
	
	websocket_url = $"/root/Config".config.gameState.url
	_connect_ws()
	_reset()
	firstcoinselect()
	$BackDrop._show("ကစားပြဲႏွင့္ခ်ိတ္ဆက္ေနသည္။ ခဏေစာင့္ေပးပါ။")

func _connect_ws():
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")

	# Initiate connection to the given URL.
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)

func _closed(was_clean = false):
	print("Closed, clean: ", was_clean)
	get_tree().change_scene("res://start/conn_error.tscn")
	#set_process(false)
	#_client = null

func _connected(proto = ""):
	var request = {
		"head":"handshake",
		"body":{
			"id":$"/root/Config".config.user.username,
			"passcode":$"/root/Config".config.gameState.passcode
		}
	}
	send(request)

func _on_data():
	var respond = _client.get_peer(1).get_packet().get_string_from_utf8();
	#print("From server: ", respond)
	print("")
	var obj = JSON.parse(respond);
	var res = obj.result
	_on_server_respond(res)

func send(data):
	var json = JSON.print(data)
	#print("From client --- " + json)
	print("")
	_client.get_peer(1).put_packet(json.to_utf8())

func _on_server_respond(respond):
	print(respond)
	match respond.head:
		"handshake":
			_handshake_respond(respond.body)
		"bet":
			_bet_respond(respond.body)
		"start":
			_start(respond.body)
		"end":
			_end(respond.body)
			
func firstcoinselect():
	var sel = $BetSelect.get_node("0")
	var pos = sel.rect_position
	sel.texture_normal=sel.texture_pressed
	pos.y-=30
	sel.rect_position.y=pos.y

func _start(body):
	if isExit:
		$"/root/bgm".volume_db = -50
		#get_tree().change_scene("res://pck/scenes/menu.tscn")
		LoadingScript.load_scene(self, "res://pck/scenes/menu.tscn")
		return
	
	_reset()
	
	$BetArea/Dragon/AnimatedSprite.visible=false
	$BetArea/Tiger/AnimatedSprite.visible=false
	$BetArea/Tie/AnimatedSprite.visible=false
	
	$BackDrop._hide()
	
	$start_bet.visible=true
	$game_status.play("start_bet")
	_playVoice("new_game")
	yield(get_tree().create_timer(1.5), "timeout")
	$start_bet.visible=false
	
	timer = body.timer
	$C1.texture = card_back
	$C2.texture = card_back
	$AnimationPlayer.play("in");
	
	for i in range(11) :
		if i >= body.winHistory.size():
			break;
		var index = body.winHistory[i]
		var rect = TextureRect.new()
		rect.texture = historyTextures[index]
		$History/HBoxContainer.add_child(rect)
	
	yield(get_tree().create_timer(1.5), "timeout")
	
	fakeBet = true
	$BetArea/Dragon/AnimatedSprite.frame=0
	$BetArea/Dragon/AnimatedSprite.visible=true
	$BetArea/Dragon/AnimatedSprite.play("default")
	$BetArea/Tiger/AnimatedSprite.frame=0
	$BetArea/Tiger/AnimatedSprite.visible=true
	$BetArea/Tiger/AnimatedSprite.play("default")
	$BetArea/Tie/AnimatedSprite.frame=0
	$BetArea/Tie/AnimatedSprite.visible=true
	$BetArea/Tie/AnimatedSprite.play("default")

func _end(body):
	$end_bet.visible=true
	$game_status.play("end_bet")
	_playVoice("stop_bet")
	yield(get_tree().create_timer(1.5), "timeout")
	$end_bet.visible=false
	
	$BetArea/Dragon/AnimatedSprite.visible=false
	$BetArea/Tiger/AnimatedSprite.visible=false
	$BetArea/Tie/AnimatedSprite.visible=false
	fakeBet = false
	yield(get_tree().create_timer(0.5), "timeout")
	
	var winIndex = int(body.winIndex)
	var c1 = body.cards[0]
	var c2 = body.cards[1]
	var key1 = str(c1.rank)+str(c1.shape)
	var key2 = str(c2.rank)+str(c2.shape)
	
	$C1.texture = card_textures[key1]
	yield(get_tree().create_timer(1), "timeout")
	$C2.texture = card_textures[key2]
	
	yield(get_tree().create_timer(1), "timeout")
	
	match winIndex:
		0:
			$dragon_win.visible=true
			_playVoice("dragon_win")
			$win_animation.play("dragon_win")
			yield(get_tree().create_timer(0.7), "timeout")
			$dragon_win.visible=false
			$BetArea/Dragon/AnimatedSprite.frame=0
			$BetArea/Dragon/AnimatedSprite.visible=true
			$BetArea/Dragon/AnimatedSprite.play("default")
		1:
			$BetArea/Tie/AnimatedSprite.frame=0
			$BetArea/Tie/AnimatedSprite.visible=true
			$BetArea/Tie/AnimatedSprite.play("default")
		2:
			$tiger_win.visible=true
			_playVoice("tiger_win")
			$win_animation.play("tiger_win")
			yield(get_tree().create_timer(0.7), "timeout")
			$tiger_win.visible=false
			$BetArea/Tiger/AnimatedSprite.frame=0
			$BetArea/Tiger/AnimatedSprite.visible=true
			$BetArea/Tiger/AnimatedSprite.play("default")
			
	$Audio/CoinMove.play()
	var winCoinCount = 0
	for coin in $CoinContainer.get_children():
		if coin.playerIndex == winIndex :
			winCoinCount += 1
		else :
			match winIndex:
				0:
					var rx = (randi() % 100) - 50
					var ry = (randi() % 100) - 50
					var target = $dragon_pos.position
					target.x+=rx
					target.y+=ry
					coin.target = target
					coin.playerIndex = -1
				1:
					var rx = (randi() % 100) - 50
					var ry = (randi() % 100) - 50
					var target = $CoinHome.position
					target.x+=rx
					target.y+=ry
					coin.target = target
					coin.playerIndex = -1
				2:	
					var rx = (randi() % 100) - 50
					var ry = (randi() % 100) - 50
					var target = $tiger_pos.position
					target.x+=rx
					target.y+=ry
					coin.target = target
					coin.playerIndex = -1
	yield(get_tree().create_timer(0.8), "timeout")
	
	$Audio/CoinMove.play()
	for coin in $CoinContainer.get_children():
		if coin.playerIndex == -1 && winCoinCount > 0:
			var rx = (randi() % 100) - 50
			var ry = (randi() % 100) - 50
			var target = betArea[winIndex].get_node("Pos").global_position
			target.x += rx
			target.y += ry
			coin.playerIndex = winIndex
			coin.target = target
#			winCoinCount -= 1
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	if myBetAmount[winIndex] > 0 :
		$AmountTransfer.get_node(str(winIndex)).set("custom_colors/font_color", Color(1,1,0))
		$AmountTransfer.get_node(str(winIndex)).text = "+" + str(myBetAmount[winIndex])
		$AmountTransfer.get_node(str(winIndex)).visible = true
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	var t = 0
	var playerWinCoin = myBetCoin[winIndex] * 2
	$Audio/CoinMove.play()
	for coin in $CoinContainer.get_children():
		if myBetAmount[winIndex] > 0 && t < playerWinCoin && coin.playerIndex == winIndex :
			coin.target = $Profile.global_position
			coin.destroyOnArrive = true
			coin.playerIndex = -2
			t += 1
	
	# Refund coin to bot
	for coin in $CoinContainer.get_children():
		if coin.playerIndex == winIndex:
			var r = randi() % 10
			if r >= 7:
				coin.target = $Bots/Players.global_position
			else :
				coin.target = bot[r].global_position
			coin.destroyOnArrive = true
			coin.playerIndex = -2
	
	yield(get_tree().create_timer(1), "timeout")
	
	$Profile/Panel/Balance.text = str(_balance_round(body.player.balance))


# For truncating Username
func truncateUsername(username, max_length):
	if username.length() > max_length:
		var truncated = username.left(max_length)
		var overflowCount = username.length() - max_length
		var overflowString = " ..."
		return truncated + overflowString
	else:
		return username


func _handshake_respond(body):
	if body.status == "ok":
		var truncatedUsername = truncateUsername(body.player.info.nickname, max_length)
		$Profile/Panel/Nickname.text = truncatedUsername
		$Profile/Panel/Balance.text = str(_balance_round(body.player.balance))
		$Profile/Img.texture = profile_textures[int(body.player.info.profile)]

func _bet_respond(body):
	$Profile/Panel/Balance.text = str(_balance_round(body.player.balance))
	betAmount[body.index] += body.amount
	myBetAmount[body.index] += body.amount
	myBetCoin[body.index] += 1
	betArea[body.index].get_node("Total").text = _balance_round(betAmount[body.index])
	betArea[body.index].get_node("Me").text = _balance_round(myBetAmount[body.index])
	$Audio/CoinMove.play()
	var coin = coinPrefab.instance()
	coin.position = $Profile.global_position
	var rx = (randi() % 100) - 50
	var ry = (randi() % 100) - 50
	var target = betArea[body.index].get_node("Pos").global_position
	target.x += rx
	target.y += ry
	coin.target = target
	coin.playerIndex = body.index
	$CoinContainer.add_child(coin)

func _load_profile_textures():
	for i in range(13):
		var path = "res://pck/assets/common/profiles/" + str(i) + ".png"
		var texture = load(path)
		profile_textures.append(texture) 

func _reset():
	for i in range(7):
		var balance = (randi() % 100000) + 100000
		botBalance[i] = balance
		bot[i].get_node("Panel/Balance").text = _balance_round(balance)
		bot[i].get_node("Profile").texture = profile_textures[randi()%13]
	betAmount = [0,0,0,]
	myBetAmount = [0,0,0,]
	myBetCoin = [0,0,0]
	for i in range(3):
		betArea[i].get_node("Total").text = _balance_round(betAmount[i])
		betArea[i].get_node("Me").text = _balance_round(myBetAmount[i])
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	for N in $AmountTransfer.get_children():
		N.visible = false
	for N in $History/HBoxContainer.get_children():
		N.queue_free()

func _process(delta):
	_client.poll()
	
	tick += delta
	if tick > wait && fakeBet :
		tick = 0
		wait = randf()+0.5
		_bot_bet()
	
	t2 += delta
	if t2 > 1:
		t2 = 0
		if timer > 0:
			timer -= 1
			$Timer/Label.text = str(timer)
			$Timer.visible = true
		else :
			$Timer.visible = false

func _bot_bet():
	$Audio/CoinMove.play()
	for i in range(7):
		var r = randi() % 12
		if r < 4:
			var coin = coinPrefab.instance()
			coin.position = bot[i].position
			var rx = (randi() % 100) - 50
			var ry = (randi() % 50) - 20
			var rb = randi() % 3
			var target = betArea[rb].get_node("Pos").global_position
			target.x += rx
			target.y += ry
			coin.target = target
			coin.playerIndex = rb
			$CoinContainer.add_child(coin)
			var amt = betArr[r]
			botBalance[i] -= amt
			betAmount[rb] += amt
			bot[i].get_node("Panel/Balance").text = _balance_round(botBalance[i])
			betArea[rb].get_node("Total").text = _balance_round(betAmount[rb])
	# Players bet
	var t = randi() % 10 + 1
	for i in range(t):
		var coin = coinPrefab.instance()
		coin.position = $Bots/Players.position
		var rx = (randi() % 100) - 50
		var ry = (randi() % 50) - 25
		var rb = randi() % 3
		var target = betArea[rb].get_node("Pos").global_position
		target.x += rx
		target.y += ry
		coin.target = target
		coin.playerIndex = rb
		$CoinContainer.add_child(coin)
		var amt = betArr[(randi() % 3)]
		betAmount[rb] += amt
		betArea[rb].get_node("Total").text = _balance_round(betAmount[rb])
		yield(get_tree().create_timer(.2), "timeout")

func _on_bet_select(index):
	if index!=selectedBet:
		prev_selected=selectedBet
		var prev_sel = $BetSelect.get_node(str(prev_selected))
		var prev_pos = prev_sel.rect_position
		prev_sel.texture_normal=prev_sel.texture_disabled
		prev_pos.y+=30
		prev_sel.rect_position.y=prev_pos.y
		var sel = $BetSelect.get_node(str(index))
		var pos = sel.rect_position
		sel.texture_normal=sel.texture_pressed
		pos.y-=30
		sel.rect_position.y=pos.y
		selectedBet = index
		print("index",index)

func _on_bet(index):
	var amount = betArr[selectedBet]
	var request = {
		"head":"bet",
		"body":{
			"amount":amount,
			"index":index
		}
	}
	send(request)

func _balance_round(balance):
	if(balance >= 1000):
		var d = stepify(balance/1000, 0.1)
		return str(d) + " K"
	else:
		return str(balance)

func _playVoice(key):
	$Audio/GameVoice.stream = GameVoices[key]
	$Audio/GameVoice.play()

func _on_Exit_pressed():
	_playVoice("exit")
	isExit = true
