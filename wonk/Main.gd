extends Control

onready var theme_manager = ThemeManager.new()
onready var MAIL = preload("Mail.tscn")
const POPUP = preload("res://Popup.tscn")

func _ready():
	theme_manager.init()
	#var file = File.new()
	set_theme(theme_manager.themes[0])
	mail_add("Google", ":)")
	mail_add("Mum", "Have are you doing, darling?")
	mail_add("uncleJoe123", "Wanna meet up some time?")
	mail_add("Duolingo", " You have not studied.")
	popup_show(200, 200, "FREE ANTIVIRUS", "X", "close", "get free", "trial", "do not get free", "buy", "sign up", "spam")

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

func mail_add(header, content):
	var mail = MAIL.instance()
	mail.get_child(0).get_child(0).text = header
	mail.get_child(0).get_child(1).text = content
	$HBoxContainer/PanelContainer/ScrollContainer/VBoxContainer.add_child(mail)
	
func popup_show(x, y, header, cancel, _cancel_f, select1, _select1_f, select2, _select2_f, select3, _select3_f):
	var popup = POPUP.instance()
	popup.set_variables(header, cancel, _cancel_f, select1, _select1_f, select2, _select2_f, select3, _select3_f)
	popup.set_position(Vector2(x, y))
	popup.main = get_tree().root.get_child(0)
