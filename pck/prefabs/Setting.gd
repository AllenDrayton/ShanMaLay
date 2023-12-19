extends Panel


var filepath = "user://setting.txt"

func _ready():
	loadSettings()
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
	
	var canvas_rid = get_canvas_item()
	# You may need to adjust these values
	VisualServer.canvas_item_set_draw_index(canvas_rid,100)
	VisualServer.canvas_item_set_z_index(canvas_rid,100)


func loadSettings():
	var file = File.new()
	if file.file_exists(filepath):
		file.open(filepath, File.READ)
		var savedData = file.get_as_text()
		file.close()

		var data = JSON.parse(savedData)
		if data and "music" in data and "effect" in data:
			var effectVol = data.effect
			var musicVol = data.music 
			$SliderEffect.value = effectVol
			$SliderMusic.value = musicVol
			AudioServer.set_bus_volume_db(1, effectVol)
			AudioServer.set_bus_volume_db(2, musicVol)
		else:
			print("Invalid or incomplete data structure in the settings file.")
			# Set default values if needed
			$SliderEffect.value = 0
			$SliderMusic.value = 0
			AudioServer.set_bus_volume_db(1, 0)
			AudioServer.set_bus_volume_db(2, 0)
	else:
		print("Settings file not found.")
		# Set default values if the file doesn't exist
		$SliderEffect.value = 0
		$SliderMusic.value = 0
		AudioServer.set_bus_volume_db(1, 0)
		AudioServer.set_bus_volume_db(2, 0)

func _save(data):
	var file = File.new()
	file.open(filepath, File.WRITE)
	file.store_string(JSON.print(data))
	file.close()


func _show():
	$AnimationPlayer.play("show")


func _hide():
	$AnimationPlayer.play("hide")


func _on_Submit_pressed():
	_hide()
	var data = {
		"music":$SliderMusic.value,
		"effect":$SliderEffect.value
	}
	_save(data)


func _on_SliderMusic_value_changed(value):
	AudioServer.set_bus_volume_db(2,value)
	print("Music : ", value)


func _on_SliderEffect_value_changed(value):
	AudioServer.set_bus_volume_db(1,value)
	print("Voice : ", value)
