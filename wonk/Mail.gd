extends Button

var MAIN

func _on_Mail_pressed():
	var t = $VBoxContainer/From.text + ": " + $VBoxContainer/Subject.text + "\n\n" + $VBoxContainer/Body.text
	MAIN.get_node("HBoxContainer/VBoxContainer/PanelContainer/Body").text = t
	
