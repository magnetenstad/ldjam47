extends Control

onready var theme_manager = ThemeManager.new()
onready var MAIL = preload("Mail.tscn")
const POPUP = preload("res://Popup.tscn")

func _ready():
	theme_manager.init()
	var file = File.new()
	set_theme(theme_manager.themes[0])
	mail_add()
	mail_add()
	
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
	popup.set_position(x, y)
