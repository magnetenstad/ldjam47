extends Node

const MAIL = preload("Mail.tscn")
const POPUP = preload("res://Popup.tscn")

onready var MAIN = get_parent()
onready var PF = preload("PopupFunctions.gd").new(get_parent())


var content

func _ready():
	content = MAIN.json_load("src/inbox.json")
	PF.popup1()
	mail_add(content["HelloGrandma"])
	mail_add(content["BankSetup"])
	mail_add(content["SurveyGroups"])
	
	
func mail_add(dict):
	var mail = MAIL.instance()
	mail.MAIN = self
	mail.get_child(0).get_child(0).text = dict["from"]
	mail.get_child(0).get_child(1).text = dict["subject"]
	mail.get_child(0).get_child(2).text = dict["body"]
	$HBoxContainer/PanelContainer/VBoxContainer/ScrollContainer/VBoxContainer.add_child(mail)
	$HBoxContainer/PanelContainer/VBoxContainer/ScrollContainer/VBoxContainer.move_child(mail, 0)
	MAIN.get_node("NotificationSound").play()
	

func _on_Button_pressed():
	MAIN.focus("World")


func _on_ReplyButton_pressed():
	PF.computer_is_hacked()
