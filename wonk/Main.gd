extends Control

onready var MAIN = get_tree().root.get_child(0)
onready var TM = ThemeManager.new()
onready var PF = preload("PopupFunctions.gd").new(MAIN)
const MAIL = preload("Mail.tscn")
const POPUP = preload("res://Popup.tscn")
var balance = 10000

func _ready():
	TM.init()
	set_theme(TM.themes[0])
#	mail_add("Google", ":)")
#	mail_add("Mum", "Have are you doing, darling?")
#	mail_add("uncleJoe123", "Wanna meet up some time?")
#	mail_add("Duolingo", " You have not studied.")
	PF.popup1()
	add_balance(0)
	var content = json_load("src/content.json")
	mail_add(content["0"])

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

func mail_add(dict):
	var mail = MAIL.instance()
	mail.MAIN = MAIN
	print(dict)
	mail.get_child(0).get_child(0).text = dict["from"]
	mail.get_child(0).get_child(1).text = dict["subject"]
	mail.get_child(0).get_child(2).text = dict["body"]
	$HBoxContainer/PanelContainer/ScrollContainer/VBoxContainer.add_child(mail)
	$HBoxContainer/PanelContainer/ScrollContainer/VBoxContainer.move_child(mail, 0)
	
func add_balance(n):
	balance += n
	$HBoxContainer/VBoxContainer/BalanceCont/BalanceLabel.text = "$" + str(balance)
