extends Node

const MAIL = preload("Mail.tscn")
const POPUP = preload("res://Popup.tscn")

onready var MAIN = get_parent()
onready var PF = preload("PopupFunctions.gd").new(self)

var balance = 10000
var content

func _ready():
	content = MAIN.json_load("src/inbox.json")
	add_balance(0)
	PF.popup1()
	mail_add(content["0"])
	
func mail_add(dict):
	var mail = MAIL.instance()
	mail.MAIN = self
	mail.get_child(0).get_child(0).text = dict["from"]
	mail.get_child(0).get_child(1).text = dict["subject"]
	mail.get_child(0).get_child(2).text = dict["body"]
	$HBoxContainer/PanelContainer/VBoxContainer/ScrollContainer/VBoxContainer.add_child(mail)
	$HBoxContainer/PanelContainer/VBoxContainer/ScrollContainer/VBoxContainer.move_child(mail, 0)
	
func add_balance(n):
	balance += n
	$HBoxContainer/VBoxContainer/BalanceCont/BalanceLabel.text = "$" + str(balance)

func _on_Button_pressed():
	MAIN.focus("World")
