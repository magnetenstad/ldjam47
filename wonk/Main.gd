extends Node
onready var TM = ThemeManager.new()

var balance = 10924
var day = -1
var week = 0
var subscriptions = []
var subscription_prices = {
	"Trompo Antivirus": 100,
	"Trompo Antivirus UltraPro": 500,
	"Jones-Barithon Saxophone Shop": 50,
	"Clown Variable Studio": 100,
	"ImageShear Pro": 100,
	"ChargeMaster Special Pro": 100,
	"WhiteScreen": 100,
	"MindTableTennis": 100,
	"DolphinBlock": 100,
	"AntiAnt Pro": 100
}
var incoming_letters = []
var incoming_payments = []

func _ready():
	TM.init()
	$Inbox.set_theme(TM.themes[0])
	$Letter.set_theme(TM.themes[0])
	$World/CanvasLayer/PanelContainer.set_theme(TM.themes[0])
	$World/CanvasLayer/LetterContainer.set_theme(TM.themes[0])
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
		$World.zoom = Vector2(0.16667, 0.16667)
	else:
		$World.zoom = Vector2(1, 1)

func lose_game():
	print("You lost the game.")

func add_balance(n):
	balance = clamp(balance+n, 0, pow(10, 9))
	$Inbox/HBoxContainer/VBoxContainer/InfoCont/HBoxContainer/BalanceLabel.text = "$" + str(balance)
	if balance == 0:
		lose_game()

func subscription_add(sub):
	if not sub in subscriptions:
		subscriptions.append(sub)

func day_from_number(num):
	match num:
		0:
			return "Monday"
		1:
			return "Tuesday"
		2:
			return "Wednesday"
		3:
			return "Thursday"
		4:
			return "Friday"
		5:
			return "Saturday"
		6:
			return "Sunday"

func _on_Time_timeout():
	$Time.start(1)
	day += 1
	if day % 7 == 0:
		week += 1
		if str(week) in $Inbox.content.keys():
			$Inbox.mail_add($Inbox.content[str(week)])
		var subscription_payments = ""
		for sub in subscriptions:
			add_balance(-subscription_prices[sub])
			subscription_payments += "Your payment for " + sub + ": $" + str(subscription_prices[sub]) + "\n\n"
		if subscription_payments != "":
			$Inbox.mail_add({"from": "Bank1", "subject": "Payment confirmation", "body": subscription_payments + "\n\nTo cancel these automatic payments, please reply to this email with a brief statement."})
		for mail in incoming_letters:
			$World.letter_receive(mail)
		var paid = false
		for payment in incoming_payments:
			add_balance(payment)
			if payment > 0: paid = true
		if not paid and week > 2:
			$World.letter_receive("Hello Aretha.\n\nWe didn't recieve any articles from you this week.\n\nRemember to send your articles to 57 Alderwood Street.")
		incoming_letters.clear()
	$Inbox/HBoxContainer/VBoxContainer/InfoCont/HBoxContainer/WeekLabel.text = day_from_number(day%7) + ", Week " + str(week)
	if week > 7 and day % 11 == 0:
		$Inbox.PF.popup_show($Inbox.PF.last_popup_x, $Inbox.PF.last_popup_y, "Buy DolphinBlock", "Tired of Dolphins? Click any button except the last to buy DolphinBlock!", "x", "dolphin", "Buy now!", "dolphin", "the last", "close", "DolphinBlock", "dolphin")
	if day == 13:
		$Inbox.mail_add($Inbox.content["BrickSuitePro"])
		subscription_add("Clown Variable Studio")
		subscription_add("ImageShear Pro")
		subscription_add("ChargeMaster Special Pro")
		subscription_add("WhiteScreen")
		subscription_add("MindTableTennis")
		subscription_add("DolphinBlock")
		subscription_add("AntiAnt Pro")
	if day > 14 and day % 3 == 0:
		$Inbox.PF.popup_show($Inbox.PF.last_popup_x, $Inbox.PF.last_popup_y, "Warning!", "Your computer might have a virus!", "x", "close", "Scan now!", "scan", "Scan later", "close", "Sponsored by Oracle", "java_ad")
	if day == 16:
		$Inbox.PF.popup1()


func _on_Music_finished():
	$Music.play()
