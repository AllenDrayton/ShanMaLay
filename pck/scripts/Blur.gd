extends Area2D

var polygonPoints = [
	Vector2(0, 896),
	Vector2(2000, 904),
	Vector2(1992, 0),
	Vector2(1520, 0),
	Vector2(1544, 208),
	Vector2(1528, 328),
	Vector2(1528, 752),
	Vector2(1189.069946, 757.296021),
	Vector2(1161, 811),
	Vector2(786, 807),
	Vector2(788, 762),
	Vector2(504, 768),
	Vector2(496, 168),
	Vector2(1424, 160),
	Vector2(1504, 120),
	Vector2(1528, 128),
	Vector2(1512, 0),
	Vector2(0, 0)] # Replace this with your actual points

#func _ready():
#	print($CollisionPolygon2D.polygon)

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		var touchPosition = event.position
		var isTouchAccepted = isPointInsidePolygon(touchPosition, polygonPoints)

		if isTouchAccepted and Config.cancel == true:
			
			if get_parent().get_node("CustomKeyboard").visible == false:
				# Your logic here for accepted touches
				Signals.emit_signal("screenTouch")
			else:
				pass

# Function to check if a point is inside a polygon
func isPointInsidePolygon(point, polygon):
	var j = polygon.size() - 1
	var oddNodes = false

	for i in range(polygon.size()):
		var vertex1 = polygon[i]
		var vertex2 = polygon[j]

		if vertex1.y < point.y and vertex2.y >= point.y or vertex2.y < point.y and vertex1.y >= point.y:
			if vertex1.x + (point.y - vertex1.y) / (vertex2.y - vertex1.y) * (vertex2.x - vertex1.x) < point.x:
				oddNodes = !oddNodes

		j = i

	return oddNodes
