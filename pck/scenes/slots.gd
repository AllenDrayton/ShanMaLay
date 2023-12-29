extends Node2D

var slot_1_textures = []
var slot_2_textures = []
var arrows = {
	"glow": preload("res://pck/assets/slots/ARROW 2.png"),
	"dull": preload("res://pck/assets/slots/ARROW 1.png")
}

func _ready():
	$Left.disabled = true
	$Left.texture_disabled = arrows["dull"]
	$Left.modulate = Color(.7,.7,.7,0.9)
	_loadTextures()
	
	if Signals.user_mute_music == true:
		Config.MUSIC.volume_db = -80
	elif Signals.user_mute_music == false:
		Config.MUSIC.volume_db = 0

## warning-ignore:unused_variable
	var request = {
		"head":"user info"
	}
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_update_info")
	http.request(url)

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _update_info(result, response_code, headers, body):
	var respond = JSON.parse(body.get_string_from_utf8()).result
	$Balance.text = comma_sep(respond.balance)
	
func comma_sep(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]

	return res

func _loadTextures():
	for i in range(10):
		var path = "res://pck/assets/slots/assets/B" + str(i+1) + ".png"
		var texture = load(path)
		slot_1_textures.append(texture)
	for ii in range(10,20):
		var path = "res://pck/assets/slots/assets/B" + str(ii+1) + ".png"
		var texture = load(path)
		slot_2_textures.append(texture)
	var slot1 = $slotContainer_1/slotProviderContainer.get_children()
	for j in range(slot1.size()):
		var slot = slot1[j]
		if slot is TextureButton:
			slot.texture_normal = slot_1_textures[j]
	var slot2 = $slotContainer_2/slotProviderContainer.get_children()
	for k in range(slot2.size()):
		var slot = slot2[k]
		if slot is TextureButton:
			slot.texture_normal = slot_2_textures[k]

func _on_slot_pressed(slotName,accessKey):
	print("Slotname: ", slotName)
	print("Access Key: ", accessKey)

func _on_Left_pressed():
	$slotAnimation.play("left")


func _on_Right_pressed():
	$slotAnimation.play("right")


func _on_slotAnimation_animation_finished(anim_name):
	if anim_name == "right":
		$Right.disabled = true
		$Right.texture_disabled = arrows["dull"]
		$Right.modulate = Color(.7,.7,.7,.8)
		$Left.flip_h = true
		$Left.disabled = false
		$Left.modulate = Color(1,1,1,1)
	else:
		$Left.disabled = true
		$Right.disabled = false
		$Left.modulate = Color(.7,.7,.7,.8)
		$Right.modulate = Color(1,1,1,1)


func _on_Back_pressed():
	Config.MUSIC.volume_db = -80
	LoadingScript.load_scene(self,"res://pck/scenes/menu.tscn")
