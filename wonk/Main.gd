extends Node
onready var TM = ThemeManager.new()

func _ready():
	TM.init()
	$Inbox.set_theme(TM.themes[0])
	$Letter.set_theme(TM.themes[0])	
	$World/PanelContainer.set_theme(TM.themes[0])	
	focus("Inbox")
	
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
		child.visible = false
	get_node(scene).visible = true
	if scene == "World":
		$World.zoom = Vector2(0.167, 0.167)
	else:
		$World.zoom = Vector2(1, 1)


