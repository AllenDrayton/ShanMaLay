extends Node2D


var download_client
var apk_version = 1
var config = {
	"pck_version":0
}
var is_downloading = false
var download_complete = false
var config_location = "user://config.json"
var pck_location = "user://update.pck"

# Called when the node enters the scene tree for the first time.
func _ready():
	process_whole_url()
#	_request()
#	get_tree().change_scene("res://pck/scenes/login.tscn")
	if Config.STATE == "S1":
		get_tree().change_scene("res://pck/scenes/splashScene.tscn")
	elif Config.STATE == "S2":
		get_tree().change_scene("res://pck/scenes/login.tscn")
	else:
		pass


func get_whole_url():
	if OS.has_feature('JavaScript'):
		return JavaScript.eval("""
			window.location.href;
		""")
	return ""


func extract_state_from_url(whole_url):
	var query_start = whole_url.find("state=")  # Find the position of "uniquekey=" in the URL
	if query_start >= 0:
		var value_start = query_start + "state=".length()  # Find the position where the value starts
		var value_end = whole_url.find("/", value_start)  # Find the position where the value ends (assuming it's followed by '/')
		
		if value_end == -1:
			value_end = whole_url.length()  # If there is no '/', consider the value until the end of the URL
		
		var state = whole_url.substr(value_start, value_end - value_start)  # Extract the unique ID
		
		return state
	
	return ""

# Function to use the whole URL
func process_whole_url():
#	var whole_url = get_whole_url()
	var whole_url = "https://example.com/state=S1"
	var state = extract_state_from_url(whole_url)
	if state != "":
		Config.STATE = state












#func _save(content):
#	var file = File.new()
#	file.open(config_location, File.WRITE)
#	file.store_string(content)
#	file.close()
#
#func _request():
#	var file = File.new()
#	if file.file_exists(config_location) :
#		file.open(config_location, File.READ)
#		config = str2var(file.get_as_text())
#	file.close()
#
#	var error = $HTTPRequest.request($"/root/Config".config.init_url)
#	if error != OK:
#		get_tree().change_scene("res://start/conn_error.tscn")
#
#func _load_existing_pck():
#	var file = File.new()
#	if !file.file_exists(pck_location) :
#		config.version = 0
#		_save(var2str(config))
#		get_tree().reload_current_scene()
#		return
#	file.close()
#	$Label.text = "Loading resources ..."
#	ProjectSettings.load_resource_pack(pck_location)
#	$Label.text = "Connecting to game server ..."
#	get_tree().change_scene("res://pck/scenes/login.tscn")
#	pass
#
#func _on_HTTPRequest_request_completed(result, response_code, headers, body):
#	print("Version check complete")
#	var json = JSON.parse(body.get_string_from_utf8())
#	if json.error == OK:
#		var res = json.result
#
#		if res.apk_version > apk_version:
#			$"/root/Config".config.download_url = res.download_url
#			get_tree().change_scene("res://start/download.tscn")
#			return
#
#		$"/root/Config".config.account_url = res.account_url
#		print(res)
#		if(res.status == "active"):
#			if(res.pck_version > config.pck_version):
#				config.pck_version = res.pck_version
#				# download update
#				download_client = HTTPRequest.new()
#				download_client.connect('request_completed', self, '_download_completed')
#
#				add_child(download_client)
#				download_client.download_file = pck_location
#				download_client.request(res.pck_url)
#				print("start downloading from " + res.pck_url)
#				is_downloading = true
#			else:
#				_load_existing_pck()
#		elif res.status == "message":
#			$"/root/Config".config.message = res.message
#			get_tree().change_scene("res://start/server_message.tscn")
#	else:
#		get_tree().change_scene("res://start/conn_error.tscn")
#
#func _download_completed(result, response_code, headers, body):
#	print("download complete")
#	if response_code == 200:
#		is_downloading = false
#		download_complete = true
#		$Label.text = "Loading resources ..."
#		ProjectSettings.load_resource_pack(pck_location)
#		$Label.text = "Connecting to game server ..."
#		print("resource load complete")
#		get_tree().change_scene("res://pck/scenes/login.tscn")
#		_save(var2str(config))
#
#func _process(delta):
#	if !is_downloading:
#		return
#	var downloaded = float(download_client.get_downloaded_bytes())
#	var total = float(download_client.get_body_size())
#	var progress = ceil((downloaded / total) * 100)
#	$TextureProgress.value = progress
#	if !download_complete && progress > 0:
#		$Label.text = "Downloading update " + str(progress) + "% ..."
#	else :
#		$Label.text = "Downloading update 0% ..."

