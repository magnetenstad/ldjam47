extends Node

const MAIL = preload("Mail.tscn")
const POPUP = preload("res://Popup.tscn")

onready var MAIN = get_parent()
onready var PF = preload("PopupFunctions.gd").new(self)

var balance = 10924
var subscriptions = []
var subscription_prices = {
	"Trompo Antivirus": 100
}
var content
var week = 0

func _ready():
	content = MAIN.json_load("src/inbox.json")
	add_balance(0)
	PF.popup1()
	mail_add(content["HelloGrandma"])
	mail_add(content["BankSetup"])
	mail_add(content["SurveyGroups"])
	_on_Time_timeout()
	
	
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
	$HBoxContainer/VBoxContainer/InfoCont/HBoxContainer/BalanceLabel.text = "$" + str(balance)

func _on_Button_pressed():
	MAIN.focus("World")


func _on_ReplyButton_pressed():
	PF.computer_is_hacked()


func _on_Time_timeout():
	$Time.start(30)
	week += 1
	$HBoxContainer/VBoxContainer/InfoCont/HBoxContainer/WeekLabel.text = "Week " + str(week)
	for sub in subscriptions:
		add_balance(-subscription_prices[sub])
		mail_add({"from": "Bank1", "subject": "Payment confirmation", "body": "Your payment for " + sub + " has gone through.\n\nSum: $" + str(subscription_prices[sub]) + "\n\nTo cancel this automatic payment, please reply to this email with a brief statement."})
