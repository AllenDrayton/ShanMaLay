extends Node

# warning-ignore:unused_signal
signal usernameUpdate(name)
# warning-ignore:unused_signal
signal musicOn
# warning-ignore:unused_signal
signal musicOff

var MUSIC = null
var cancel = true
var VERSION = 1.1

var config = {
	"name":"ShanMaLay",
	"init_url":"http://casino909.com/app_control/shanmalay",
#	"account_url":"http://mclubskm.com:9690/api/"
	"account_url":"http://localhost:9690/api/"
}

# Server ip : 167.71.221.136

