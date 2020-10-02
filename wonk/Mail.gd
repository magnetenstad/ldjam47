extends Button

var MAIN

func _on_Mail_pressed():
	MAIN.get_node("HBoxContainer/PanelContainer2/Body").text = $VBoxContainer/Body.text
	
