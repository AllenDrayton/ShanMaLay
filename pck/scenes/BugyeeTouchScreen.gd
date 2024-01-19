extends Area2D

var polygonPoints = [
	Vector2(3, 328),
	Vector2(229, 333),
	Vector2(215, 118),
	Vector2(141, 99),
	Vector2(110, -15),
	Vector2(2003, 0),
	Vector2(2006, 114),
	Vector2(1328, 116),
	Vector2(1105.910034, 168.617004),
	Vector2(1093, 185),
	Vector2(657, 383),
	Vector2(963, 259),
	Vector2(1135, 177),
	Vector2(1198, 148),
	Vector2(1331, 134),
	Vector2(1347, 901),
	Vector2(1997, 903),
	Vector2(2001, 989),
	Vector2(1033, 972),
	Vector2(-4, 982)
] # Replace this with your actual points

func _ready():
	print($CollisionPolygon2D.polygon)

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		var touchPosition = event.position
		var isTouchAccepted = isPointInsidePolygon(touchPosition, polygonPoints)

		if isTouchAccepted and Config.cancel == true:
			# Your logic here for accepted touches
			Signals.emit_signal("screenTouch")

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
