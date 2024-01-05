extends Node


var config = {
	"name":"ShanMaLay",
	"init_url":"http://casino909.com/app_control/shanmalay",
#	"account_url":"http://localhost:9690/api/"
#	"account_url":"http://shanmalay.com:9690/api/",
	"account_url":"http://smlnn.com:9690/api/",
#	"account_url":"http://mclubskm.com:9690/api/",
	
	"mobile":{
		"isMobile": "1",
		"type": "true"
	},
	"web":{
		"isMobile": "0",
		"type": "false"
	}
	
}

signal enterPressed

var slot_url

var user_text = "placeholder"
# Server ip : 167.71.221.136


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
