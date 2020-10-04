extends Control

onready var MAIN = get_parent()
onready var LF = preload("LetterFunctions.gd").new(MAIN)
var content
	
func _ready():
	content = MAIN.json_load("src/letter.json")
	
func _on_ButtonDiscard_pressed():
	MAIN.focus("World")
	
func _on_ButtonSend_pressed():
	for key in content.keys():
		var run
		if "," in key:
			run = true
			for k in key.split(","):
				if not k in $TextEdit.text.to_lower():
					run = false
		else:
			run = key in $TextEdit.text.to_lower()
		
		if run:
			var line = content[key].split("(")
			LF.callv(line[0], line[1].trim_suffix(")").split(","))
		else:
			MAIN.incoming_mail.append("In return: \n" + $TextEdit.text + "\n\nSent in week " + str(MAIN.week))
	MAIN.focus("World")
	
