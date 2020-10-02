extends Control

onready var theme_manager = ThemeManager.new()
onready var MAIL = preload("Mail.tscn")
const POPUP = preload("res://Popup.tscn")
var last_popup_x = 0
var last_popup_y = 0

func _ready():
	theme_manager.init()
	#var file = File.new()
	set_theme(theme_manager.themes[0])
	mail_add()
	mail_add()
	popup1()

func popup1():
	popup_show(last_popup_x+10, last_popup_y+10, "FREE ANTIVIRUS", "X", "close", "get free", "trial", "do not get free", "buy", "sign up", "popup_sign_up")
	last_popup_x += 10
	last_popup_y += 10
	
func popup_sign_up():
	popup_show(last_popup_x+10, last_popup_y+10, "SIGN UP", "X", "close", "sign up with email", "buy", "sign up with phone", "buy", "do not sign up", "spam_sad")
	last_popup_x += 10
	last_popup_y += 10
	
func spam_sad():
	for i in range(10):
		popup_show(last_popup_x+10, last_popup_y+10, "WE're SAD TO SEE YOU GO", "X", "close", "", "", "", "", "", "")
		last_popup_x += 10
		last_popup_y += 10
		
func trial():
	# code for signing up for trial, autopay after 30 days
	pass
func buy():
	# code for buying
	pass
func spam():
	# func for sending 100 spam mails
	pass

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

func mail_add():
	var mail = MAIL.instance()
	$HBoxContainer/PanelContainer/VBoxContainer.add_child(mail)

func popup_show(x, y, header, cancel, _cancel_f, select1, _select1_f, select2, _select2_f, select3, _select3_f):
	var popup = POPUP.instance()
	popup.set_variables(header, cancel, _cancel_f, select1, _select1_f, select2, _select2_f, select3, _select3_f)
	popup.set_position(Vector2(x, y))
	popup.main = get_tree().root.get_child(0)
	popup.main.add_child(popup)
