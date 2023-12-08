extends Node2D

var progress = 100

func _process(delta):
	$TextureProgress.value = progress
	progress -= 10 * delta
