extends Control

func load_web_page(url: String):
	var iframe_code = "<iframe src=\"" + url + "\" width=\"100%\" height=\"100%\"></iframe>"
	get_node("WebViewContainer").set("custom_html", iframe_code)
