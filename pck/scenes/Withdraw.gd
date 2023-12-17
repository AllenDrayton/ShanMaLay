extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var request = {
		"head":"user info"
	}
	var url = $"/root/Config".config.account_url + "user_info?id=" + $"/root/Config".config.user.id
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed",self,"_update_info")
	http.request(url)
#	$withdrawAnimation.play("In")
	
func _update_info(result, response_code, headers, body):
	var respond = JSON.parse(body.get_string_from_utf8()).result
	print(respond)
	$Withdraw_panel/Balance1.text = comma_sep(respond.balance)
	$Withdraw_panel/Balance2.text = comma_sep(respond.balance)
	
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
#	get_tree().change_scene("res://pck/scenes/menu.tscn")
	hide()

func _on_TextureButton_pressed():
	get_tree().change_scene("res://pck/scenes/Bank_info.tscn")


func _on_withdraw2_pressed():
	get_parent().get_node("transfer").show()
	get_parent().get_node("transfer").get_node("transfer_history").show()
#	get_tree().change_scene("res://pck/scenes/transfer_history.tscn")
