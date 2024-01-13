extends Node2D

func _ready():
	$AnimationPlayer.play("New Anim")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "New Anim":
		$AnimationPlayer.play("loop")
	else:
		$AnimationPlayer.play("New Anim")
