extends Button

var MAIN

func _on_Mail_pressed():
	MAIN.get_node("HBoxContainer/VBoxContainer/PanelContainer/Body").text = $VBoxContainer/Body.text
	
