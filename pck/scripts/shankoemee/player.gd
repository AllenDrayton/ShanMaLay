extends Node2D

const profile_textures = []

const textures = {
	"win":preload("res://pck/assets/shankoemee/LoadingFrame/Winflag.png"),
	"lose":preload("res://pck/assets/shankoemee/LoadingFrame/Loseflag.png")
}

#const flag_textures = {
#	"auto":preload("res://pck/assets/shankoemee/auto-flag.png"),
#	"pauk":preload("res://pck/assets/shankoemee/pauk-flag.png")
#}


const flag_textures = {
	"auto8":preload("res://pck/assets/shankoemee/LoadingFrame/auto8.png"),
	"auto9":preload("res://pck/assets/shankoemee/LoadingFrame/auto9.png"),
	"pauk":preload("res://pck/assets/shankoemee/LoadingFrame/DR1.png")
}


#const auto89_textures = {
#	"auto8":preload("res://pck/assets/shankoemee/LoadingFrame/auto8.png"),
#	"auto9":preload("res://pck/assets/shankoemee/LoadingFrame/auto9.png")
#
#}

const multiply = {
	2:preload("res://pck/assets/shankoemee/2x.png"),
	3:preload("res://pck/assets/shankoemee/3x.png"),
	5:preload("res://pck/assets/shankoemee/5x.png"),
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


var voices = {
	"bet_more":preload("res://pck/assets/common/messages/bet_more.ogg"),
	"haha":preload("res://pck/assets/common/messages/A_Haha.mp3"),
	"hurry":preload("res://pck/assets/common/messages/A_MyanLoke.mp3"),
	"lose":preload("res://pck/assets/common/messages/A_NgrShonePe.mp3"),
	"mingalar":preload("res://pck/assets/common/messages/A_Mingalarpa.mp3"),
	"play_again":preload("res://pck/assets/common/messages/A_MaTwrNeOmm.mp3"),
	"quit":preload("res://pck/assets/common/messages/A_TorPeKwr.mp3")
}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Connect the Signals
	#Signals.connect("clear_auto_flag", self, "_hide_auto_flag")
	#Signals.connect("message_sent",self,"_on_message_sent")
# warning-ignore:return_value_discarded
	Signals.connect("bet_pressed", self, "_bet_is_pressed")

	
	
	_load_profile_textures()
	visible = false
# warning-ignore:return_value_discarded
	$CountDown.connect("animation_finished",self,"_stop_count_down")
	_reset()

func _load_profile_textures():
	for i in range(26):
		var path = "res://pck/assets/HomeScence/Home-Photo/icon-photo-" + str(i+1) + ".png"
		var texture = load(path)
		profile_textures.append(texture) 

func _reset():
	$Catch.visible = false
	$PaukFlag.visible = false
	$Auto8_9.visible = false
	$ResultFlag.visible = false
	$Bet/Label.text = "0"
	_hide_multiply()

func _set_info(nickname, balance, profile):
	$Panel/Nickname.text = nickname
	_set_balance(balance)
	$Profile.texture = profile_textures[int(profile)]

func _set_balance(balance):
	if(balance >= 1000):
		var d = stepify(balance/1000, 0.1)
		$Panel/Balance.text = str(d) + " K"
	else:
		$Panel/Balance.text = str(balance)

func _bet_pos():
	return $Bet.global_position

func _banker_pos():
	return $Bet/banker_position.global_position

func _hide_bet():
	$Bet.visible = false

func _set_bet(bet):
	$Bet.visible = true
	$Bet/Label.text = str(bet)

func _show_pauk(num):
	if num >= 8:
#		$PaukFlag/Label.text = str(num) + " ayguf"
#		$PaukFlag.texture = flag_textures["auto"]
		if Signals.two_card_auto == true:
			if num == 8:
				$PaukFlag.texture = flag_textures["auto8"]
			elif num == 9:
				$PaukFlag.texture = flag_textures["auto9"]
			$PaukFlag/Label.visible = false
		else:
			$PaukFlag.texture = flag_textures["pauk"]
			$PaukFlag/Label.text = str(num) + " ayguf"
			$PaukFlag/Label.visible = true
			#$PaukFlag.position.y = 68
	else :
		if num == 0:
			$PaukFlag/Label.text = "bl"
		else:
			$PaukFlag/Label.text = str(num) + " ayguf"
		$PaukFlag.texture = flag_textures["pauk"]
		$PaukFlag/Label.visible = true
		#$PaukFlag.position.y = 68
	$PaukFlag.visible = true
		


#func _hide_auto_flag():
#	$Auto8_9.visible = false

func _show_catch():
	$Catch.visible = true

func _hide_catch():
	$Catch.visible = false

func _show_result_flag(isWin):
	if isWin == true:
		$ResultFlag.texture = textures.win
	else :
		$ResultFlag.texture = textures.lose
	$ResultFlag.visible = true

func _hide_result_flag():
	$ResultFlag.visible = false

func _stop_count_down():
	$CountDown.playing = false
	$CountDown.frame = 0
	$CountDown.visible = false
	
	$PlayerLoading.playing = false
	$PlayerLoading.frame = 0
	$PlayerLoading.visible = false
	Signals.emit_signal("bet_pos_visible")
	$Bet.z_index = 0
	
	$CardLoading.playing = false
	$CardLoading.frame = 0
	$CardLoading.visible = false
	

func _set_count_down(sec):
	if sec == 0 :
		return
	$CountDown.speed_scale = 1/float(sec)
	$CountDown.frame = 0
	$CountDown.playing = true
	#$CountDown.visible = true
	#$PlayerLoading.speed_scale = 1/float(sec)
	#$PlayerLoading.frame = 0
	
	
# Player Loading
func _player_wait_countdown(sec):
	if sec == 0 :
		return
	$PlayerLoading.playing = true
	$PlayerLoading.visible = true
	Signals.emit_signal("bet_pos_invisible")
	$Bet.z_index = -10
	

# Cards Loading
func _card_wait_countdown(sec):
	if sec == 0 :
		return
	$CardLoading.playing = true
	$CardLoading.visible = true

func _bet_is_pressed():
	$Bet.z_index = 0
	$PlayerLoading.visible = false

func _play_emoji(emoji):
	$Emoji.play(emoji)
	$Emoji.visible = true
	yield(get_tree().create_timer(2), "timeout")
	$Emoji.stop()
	$Emoji.visible = false

func _show_multiply(x):
	$Multiply.texture = multiply[x]
	$Multiply.visible = true
	$Multiply/AnimationPlayer.play("show")

func _hide_multiply():
	$Multiply/AnimationPlayer.play("hide")
	yield(get_tree().create_timer(0.5), "timeout")
	$Multiply.visible = false

func _transfer_balance(amount):
	if amount > 0 :
		get_node("TransferBalance/Label").set("custom_colors/font_color", Color(1.0, 0.84, 0.0))
		get_node("TransferBalance/Label").set("custom_colors/font_outline_modulate", Color(0.6, 0.4, 0.2))
		get_node("TransferBalance/Label").text = "+" + str(amount)
	else :
		get_node("TransferBalance/Label").set("custom_colors/font_color", Color(0.8, 0.8, 0.8))
		get_node("TransferBalance/Label").set("custom_colors/font_outline_modulate", Color(0.2, 0.2, 0.2))
		get_node("TransferBalance/Label").text = str(amount)
	get_node("TransferBalance/AnimationPlayer").play("show")

func _play_message(msg):
	$AudioStreamPlayer.stream = voices[msg]
	$AudioStreamPlayer.play()
	#$Message.texture = msg_textures[msg]
	#$Message/AnimationPlayer.play("show")
	$MessageReply/MessageReplyText.text = message_texts[msg]
	$MessageReply.visible = true
	$MessageTimer.start()


func _on_MessageTimer_timeout():
	$MessageReply.visible = false

#func _on_message_sent(message):
#	_display_input_message(message)
	
func _display_input_message(msg):
	$UserMessageInput.visible = true
	$UserMessageInput/Input.text = msg
	$MessageInputTimer.start()
	
	
func _on_MessageInputTimer_timeout():
	$UserMessageInput.visible = false
