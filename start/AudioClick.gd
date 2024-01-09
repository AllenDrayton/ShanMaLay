extends AudioStreamPlayer
var audio_stream_player : AudioStreamPlayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func stop_audio():
	audio_stream_player.stop()
