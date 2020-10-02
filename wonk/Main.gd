extends Control

onready var theme_manager = ThemeManager.new()
onready var PF = preload("PopupFunctions.gd").new(get_tree().root.get_child(0))
const MAIL = preload("Mail.tscn")
const POPUP = preload("res://Popup.tscn")
var last_popup_x = 300
var last_popup_y = 50

func _ready():
	theme_manager.init()
	#var file = File.new()
	set_theme(theme_manager.themes[0])
	mail_add("Google", ":)")
	mail_add("Mum", "Have are you doing, darling?")
	mail_add("F. Kurusch", "Weekend reading")
	mail_add("uncleJoe123", "Wanna meet up some time?")
	mail_add("Duolingo", " You have not studied.")
<<<<<<< Updated upstream
	PF.popup1()
=======
	mail_add("F. Kurusch", "Weekend reading")
	mail_add("F. Kurusch", "Weekday reading")
	mail_add("F. Kurusch", "Does anyone have any questions?")
	mail_add("F. Kurusch", "I did not understand your questions.")
	popup1()

func popup1():
	popup_show(last_popup_x, last_popup_y, "FREE ANTIVIRUS", "We have to you give free antivirus!!! defnitely remove all virus.", "X", "close", "get free", "trial", "do not get free", "buy(1)", "sign up", "popup_sign_up")

func popup_sign_up():
	popup_show(last_popup_x, last_popup_y, "SIGN UP", "Ah thank YOU FOr trying our product!! woo", "X", "close", "sign up with email", "buy", "sign up with phone", "buy", "do not sign up", "spam_sad")

func spam_sad():
	for i in range(10):
		popup_show(last_popup_x, last_popup_y, "WE're SAD TO SEE YOU GO", "why are you leaving", "X", "close", "", "", "", "", "", "")

func trial():
	# code for signing up for trial, autopay after 30 days
	pass
func buy(n):
	mail_add("F. Kurusch", "Thank you for buying our product. Price: $" + str(n))
func spam():
	# func for sending 100 spam mails
	pass
>>>>>>> Stashed changes

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

func mail_add(header, content):
	var mail = MAIL.instance()
	mail.get_child(0).get_child(0).text = header
	mail.get_child(0).get_child(1).text = content
	$HBoxContainer/PanelContainer/ScrollContainer/VBoxContainer.add_child(mail)
<<<<<<< Updated upstream
=======

func popup_show(x, y, header, body, cancel, _cancel_f, select1, _select1_f, select2, _select2_f, select3, _select3_f):
	var popup = POPUP.instance()
	popup.set_variables(header, body, cancel, _cancel_f, select1, _select1_f, select2, _select2_f, select3, _select3_f)
	popup.set_position(Vector2(x, y))
	popup.main = get_tree().root.get_child(0)
	popup.main.add_child(popup)
	last_popup_x += 10
	last_popup_y += 10
>>>>>>> Stashed changes
