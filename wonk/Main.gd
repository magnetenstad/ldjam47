extends Node
onready var TM = ThemeManager.new()

var balance = 10924
var week = 0
var subscriptions = []
var subscription_prices = {
	"Trompo Antivirus": 100
}
var incoming_mail = []

func _ready():
	TM.init()
	$Inbox.set_theme(TM.themes[0])
	$Letter.set_theme(TM.themes[0])	
	$World/PanelContainer.set_theme(TM.themes[0])	
	focus("World")
	_on_Time_timeout()
	add_balance(0)
	
func file_save(content, path):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(content)
	file.close()

func file_load(path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content

func json_save(content, path):
	var dateDict = OS.get_date()
	var day = dateDict.day
	file_save(JSON.print(content), path)
	if !content.empty():
		file_save(JSON.print(content), "user://[" + str(day) + "]" + path)

func json_load(path):
	return parse_json(file_load(path))
	
func focus(scene):
	for child in get_children():
		if "visible" in child:
			child.visible = false
	get_node(scene).visible = true
	if scene == "World":
		$World.zoom = Vector2(0.167, 0.167)
	else:
		$World.zoom = Vector2(1, 1)

func add_balance(n):
	balance += n
	$Inbox/HBoxContainer/VBoxContainer/InfoCont/HBoxContainer/BalanceLabel.text = "$" + str(balance)

func _on_Time_timeout():
	$Time.start(2)
	week += 1
	$Inbox/HBoxContainer/VBoxContainer/InfoCont/HBoxContainer/WeekLabel.text = "Week " + str(week)
	for sub in subscriptions:
		add_balance(-subscription_prices[sub])
		$Inbox.mail_add({"from": "Bank1", "subject": "Payment confirmation", "body": "Your payment for " + sub + " has gone through.\n\nSum: $" + str(subscription_prices[sub]) + "\n\nTo cancel this automatic payment, please reply to this email with a brief statement."})
	for mail in incoming_mail:
		$World.letter_receive(mail)
	incoming_mail = []


