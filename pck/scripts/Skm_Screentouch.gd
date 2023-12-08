extends Area2D


var polygonPoints = [
	Vector2(112, -1),
	Vector2(117, 40),
	Vector2(105, 97),
	Vector2(260, 105),
	Vector2(257, 343),
	Vector2(235, 359),
	Vector2(1, 356),
	Vector2(1, 896),
	Vector2(1342, 895),
	Vector2(1338, 113),
	Vector2(2000, 112),
	Vector2(2001, 0)
] # Replace this with your actual points
 
func _ready():
	print($CollisionPolygon2D.polygon)
 
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		var touchPosition = event.position
		var isTouchAccepted = isPointInsidePolygon(touchPosition, polygonPoints)
 
		if isTouchAccepted:
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
