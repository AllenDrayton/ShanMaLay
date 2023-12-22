extends CanvasLayer

var filepath = "user://setting.txt"
var isMusicMuted = false
var isSoundMuted =false
onready var off = load("res://pck/assets/Home-Setting/icon-setting-off.png")
onready var on = load("res://pck/assets/Home-Setting/icon-setting-on.png")
onready var musicAction=on
onready var soundAction=on

func saveSettings():
	var data = {
		"music_muted": isMusicMuted,
		"sound_muted": isSoundMuted
	}
	_save(data)

func loadSettings():
	var file = File.new()
	if file.file_exists(filepath):
		file.open(filepath, File.READ)
		var savedData = file.get_as_text()
		var data = JSON.parse(savedData)
		file.close()
		if "music_muted" in data:
			isMusicMuted = data["music_muted"]
		if "sound_muted" in data:
			isSoundMuted = data["sound_muted"]
		if isMusicMuted:
			muteMusic()
		else:
			unmuteMusic()
			
		if isSoundMuted:
			muteSound()
		else:
			unmuteSound()
		
#	else:
#		saveSettings()
#		isMusicMuted = obj.music_muted
#		isSoundMuted = obj.sound_muted
#
#		if isMusicMuted:
#			muteMusic()
#		else:
#			unmuteMusic()
#
#		if isSoundMuted:
#			muteMusic()
#		else:
#			unmuteMusic()
#	else:
#		saveSettings()
			
func _save(data):
	var file = File.new()
	file.open(filepath, File.WRITE)
	file.store_string(JSON.print(data))
	file.close()




#var data = {
#	"music": $music.value,
#	"sound": $sound.value,
#}

#
#func _ready():
#	$settingAnimation.play("RESET")
#	var file = File.new()
#	if file.file_exists(filepath):
#		file.open(filepath, File.READ)
#		var data = file.get_as_text()
#		var obj = JSON.parse(data)
#		file.close()
#		var effectVol = obj.result.effect
#		var musicVol = obj.result.music 
#		$SliderEffect.value = effectVol
#		$SliderMusic.value = musicVol
#		AudioServer.set_bus_volume_db(1,effectVol)
#		AudioServer.set_bus_volume_db(2,musicVol)
#
##	var canvas_rid = get_canvas_item()
##	# You may need to adjust these values
##	VisualServer.canvas_item_set_draw_index(canvas_rid,100)
##	VisualServer.canvas_item_set_z_index(canvas_rid,100)
#
#



#func _show():
#	$AnimationPlayer.play("show")
#
#
#func _hide():
#	$AnimationPlayer.play("hide")
	


#func _on_Submit_pressed():
##	_hide()
#	var data = {
#		"music":$SliderMusic.value,
#		"effect":$SliderEffect.value
#	}
#	_save(data)

#
#func _on_SliderMusic_value_changed(value):
#	AudioServer.set_bus_volume_db(2,value)
#
#
#func _on_SliderEffect_value_changed(value):
#	AudioServer.set_bus_volume_db(1,value)
#
#
#func _on_Submit_mouse_entered():
#	$Submit.rect_scale = Vector2(1.1,1.1)
#
#
#func _on_Submit_mouse_exited():
#	$Submit.rect_scale = Vector2(1,1)

func _ready():
#	set_as_toplevel(true)
	loadSettings()
	$settingbox/music.connect("pressed", self, "_on_music_pressed")
	$settingbox/music.texture_normal = musicAction
	$settingbox/sound.connect("pressed", self, "_on_sound_pressed")
	$settingbox/sound.texture_normal = soundAction
	

	
	
#	var file = File.new()Res
#	if file.file_exists(filepath):
#		file.open(filepath, File.READ)
#		var savedData = file.get_as_text()
#		var obj = JSON.parse(savedData)
#		print(obj.result.music_muted)
#		print(obj.result.sound_muted)
#		file.close()
#		isMusicMuted = obj.result.music_muted
#		isSoundMuted = obj.result.sound_muted
#		$CheckMusic.pressed = isMusicMuted
#		$CheckSound.pressed = isSoundMuted
#		if isMusicMuted:
#			muteMusic()
#		if isSoundMuted:
#			muteSound()
			
#func _save(data):
#	var file = File.new()
#	file.open(filepath, File.WRITE)
#	file.store_string(JSON.print(data))
#	file.close()

func _on_Exit_pressed():
#	get_tree().change_scene("res://pck/scenes/menu.tscn")
	hide()
	
func _on_music_pressed():
	isMusicMuted = !isMusicMuted
	if isMusicMuted:
		muteMusic()
	else:
		unmuteMusic()
	saveSettings()
	print("----------")
	
func muteMusic():
#	$"/root/bgm".stop()
	Config.MUSIC.volume_db = -80
	musicAction = off
	$settingbox/music.texture_normal = musicAction
	print("Tunroff")

func unmuteMusic():
#	$"/root/bgm".play()
	Config.MUSIC.volume_db = 0
	musicAction = on
	$settingbox/music.texture_normal = musicAction
	print("Music unmuted")

func _on_sound_pressed():
	isSoundMuted = !isSoundMuted
	if isSoundMuted:
		muteSound()
	else:
		unmuteSound()
	saveSettings()
	print("----------")
	
func muteSound():
	AudioClick.volume_db=-80
	print(AudioClick.volume_db)
	print(ExitClick.volume_db)
	ExitClick.volume_db=-80
	soundAction=off
	$settingbox/sound.texture_normal = soundAction
	print("Tunroff")
	
func unmuteSound():
	AudioClick.volume_db=0
	ExitClick.volume_db=0
	print(AudioClick.volume_db)
	print(ExitClick.volume_db)
	soundAction=on
	$settingbox/sound.texture_normal = soundAction
	print("Tunron")
	
	

