extends Control

onready var MAIN = get_parent()
var content

func printprint(string1, string2):
	print(string1, string2)
	
func _ready():
	content = MAIN.json_load("src/letter.json")
	
func _on_ButtonDiscard_pressed():
	MAIN.focus("World")
	
func _on_ButtonSend_pressed():
	for key in content.keys():
		if key in $TextEdit.text:
			var line = content[key].split("(")
			callv(line[0], line[1].replace(")", "").split(","))
	MAIN.focus("World")
	
