extends Sprite

export var speed = 1000
# -2 - nobody, -1 - dealer, 0 to 7 - player
var playerIndex = -2
var target = Vector2(0,0)
var destroyOnArrive = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position.move_toward(target,delta*speed)
	if destroyOnArrive == true :
		if position == target :
			queue_free()
