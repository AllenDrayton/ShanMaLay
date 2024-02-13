extends Node2D

const profile_textures = []
var cardPosArray = []

const textures = {
	"win":preload("res://pck/assets/shankoemee/win.png"),
	"winNew":preload("res://pck/assets/bugyeeNew/Win/win design.png"),
	"lose":preload("res://pck/assets/shankoemee/lose.png")
}

var msg_textures = {
	"bet_more":preload("res://pck/assets/common/messages/bet_more.png"),
	"haha":preload("res://pck/assets/common/messages/haha.png"),
	"hurry":preload("res://pck/assets/common/messages/hurry.png"),
	"lose":preload("res://pck/assets/common/messages/lose.png"),
	"mingalar":preload("res://pck/assets/common/messages/mingalar.png"),
	"play_again":preload("res://pck/assets/common/messages/play_again.png"),
	"quit":preload("res://pck/assets/common/messages/quit.png")
}

var message_texts = {
	"bet_more":"bet_more",
	"haha":"[m;[m;",
	"hurry":"jrefjrefvkyf",
	"lose":"igawmh&SHk;awmhrSmyJ",
	"mingalar":"r*Fvmyg",
	"play_again":"roGm;eJ. OD;aemf?xyfupm;OD;",
	"quit":"igxGufawmhr,f",
}

var za_textures = {
	"2x":preload("res://pck/assets/bugyeeNew/Za/x-2.png"),
	"3x":preload("res://pck/assets/bugyeeNew/Za/x-3.png"),
	"4x":preload("res://pck/assets/bugyeeNew/Za/x-4.png"),
	"5x":preload("res://pck/assets/bugyeeNew/Za/x-5.png")
}

#var voices = {
#	"bet_more":preload("res://pck/assets/common/messages/bet_more.ogg"),
#	"haha":preload("res://pck/assets/common/messages/haha.ogg"),
#	"hurry":preload("res://pck/assets/common/messages/hurry.ogg"),
#	"lose":preload("res://pck/assets/common/messages/lose.ogg"),
#	"mingalar":preload("res://pck/assets/common/messages/mingalar.ogg"),
#	"play_again":preload("res://pck/assets/common/messages/play_again.ogg"),
#	"quit":preload("res://pck/assets/common/messages/quit.ogg")
#}

var voices = {
	"bet_more":preload("res://pck/assets/common/messages/bet_more.ogg"),
	"haha":preload("res://pck/assets/common/messages/A_Haha.mp3"),
	"hurry":preload("res://pck/assets/common/messages/A_MyanLoke.mp3"),
	"lose":preload("res://pck/assets/common/messages/A_NgrShonePe.mp3"),
	"mingalar":preload("res://pck/assets/common/messages/A_Mingalarpa.mp3"),
	"play_again":preload("res://pck/assets/common/messages/A_MaTwrNeOmm.mp3"),
	"quit":preload("res://pck/assets/common/messages/A_TorPeKwr.mp3")
}

func _ready():
	_load_profile_textures()
	visible = false
	$ResultFlag.visible = false
	$Profile/Bet.visible = false
	
	var cards = get_node("CardPos")
	for card in cards.get_children():
		cardPosArray.append(card.global_position)
		card.queue_free()


func _reset():
	_hide_result_flag()
	_hide_bet()
	_hide_card_status()
	_hide_zaFlag()

func _transfer_balance(amount):
	if amount > 0 :
		get_node("TransferBalance/Label").set("custom_colors/font_color", Color(0,1,0))
		get_node("TransferBalance/Label").text = "+" + str(amount)
	else :
		get_node("TransferBalance/Label").set("custom_colors/font_color", Color(1,0,0))
		get_node("TransferBalance/Label").text = str(amount)
	get_node("TransferBalance/AnimationPlayer").play("show")
	pass

func _show_card_status(status):
	var zaflag = $Profile/ZaFlag
	zaflag.scale = Vector2(.08,.08)
	if status == 0: # m phyik phl 
		get_node("CardStatus/BG/Label").text = "rjzpfzJ"
		get_node("CardStatus/BG").show()
	elif status == 10: # bugyee 5x
		get_node("CardStatus/BG/Label").text = "blMuD;"
		get_node("CardStatus/BG").show()
		zaflag.texture = za_textures["5x"]
		zaflag.show()
		$Profile/bg.show()
	elif status == 11:
		get_node("CardStatus/BG/Label").text = "blav;"
		get_node("CardStatus/BG").show()
	elif status == 1:
		get_node("CardStatus/PaukGif").play("1")
		get_node("CardStatus/BG").hide()
	elif status == 2:
		get_node("CardStatus/PaukGif").play("2")
		get_node("CardStatus/BG").hide()
	elif status == 3:
		get_node("CardStatus/PaukGif").play("3")
		get_node("CardStatus/BG").hide()
	elif status == 4:
		get_node("CardStatus/PaukGif").play("4")
		get_node("CardStatus/BG").hide()
	elif status == 5:
		get_node("CardStatus/PaukGif").play("5")
		get_node("CardStatus/BG").hide()
	elif status == 6:
		get_node("CardStatus/PaukGif").play("6")
		get_node("CardStatus/BG").hide()
	elif status == 7: # 7 pauk 2x
		get_node("CardStatus/PaukGif").play("7")
		get_node("CardStatus/BG").hide()
		zaflag.texture = za_textures["2x"]
		$Profile/bg.show()
		zaflag.show()
	elif status == 8: # 8 pauk 2x 
		get_node("CardStatus/PaukGif").play("8")
		get_node("CardStatus/BG").hide()
		zaflag.texture = za_textures["2x"]
		$Profile/bg.show()
		zaflag.show()
	elif status == 9: # 9 pauk 3x
		get_node("CardStatus/PaukGif").play("9")
		get_node("CardStatus/BG").hide()
		zaflag.texture = za_textures["3x"]
		$Profile/bg.show()
		zaflag.show()
#	else:
#		get_node("CardStatus/BG/Label").text = str(status) + " ayguf"
	get_node("CardStatus/AnimationPlayer").play("show")

func _hide_card_status():
	$CardStatus/AnimationPlayer.play("hide")

func _show_bet(x):
	$Profile/Bet.text = "x" + str(x)
	$Profile/Bet.visible = true

func _hide_zaFlag():
	$Profile/ZaFlag.hide()
	$Profile/bg.hide()

func _hide_bet():
	$Profile/Bet.visible = false

func _load_profile_textures():
	for i in range(26):
		var path = "res://pck/assets/HomeScence/Home-Photo/icon-photo-" + str(i+1) + ".png"
		var texture = load(path)
		profile_textures.append(texture) 

func _set_info(nickname, balance, profile):
	$Panel/Nickname.text = nickname
	_set_balance(balance)
	$Profile/profile.texture = profile_textures[int(profile)]
	$Profile/profile.expand = true
	$Profile/profile.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT

func _set_balance(balance):
	if(balance >= 1000):
		var d = stepify(balance/1000, 0.1)
		$Panel/Balance.text = str(d) + " K"
	else:
		$Panel/Balance.text = str(balance)

func _show_result_flag(isWin):
	if isWin == true:
		get_node("ResultFlag").texture = textures.win
	else :
		get_node("ResultFlag").texture = textures.lose
	get_node("ResultFlag").visible = true

func _show_Result(isWin):
	if isWin == true:
		get_node("ResultFlag").texture = textures.winNew
	else:
		get_node("ResultFlag").texture = textures.lose
	get_node("ResultFlag").show()

func _hide_result_flag():
	$ResultFlag.visible = false

func _play_emoji(emoji):
	$Emoji.play(emoji)
	$Emoji.visible = true
	yield(get_tree().create_timer(2), "timeout")
	$Emoji.stop()
	$Emoji.visible = false

func _play_message(msg):
	$AudioStreamPlayer.stream = voices[msg]
	$AudioStreamPlayer.play()
	#$Message.texture = msg_textures[msg]
	#$Message/AnimationPlayer.play("show")
	$MessageReply/MessageReplyText.text = message_texts[msg]
	$MessageReply.visible = true
	$MessageTimer.start()


func _on_MessageTimer_timeout():
	$MessageReply.hide()
