extends Node
var MAIN
var text

func scanner_interpret(text):
	var new_text = "The scanner has attempted to interpret your document.\n\n---\n\n"
	for letter in text:
		if rand_range(0, 1) > 0.92:
			new_text += "?"
		else:
			new_text += letter
	new_text += "\n\n---"
	return new_text


func _on_Close_pressed():
	MAIN.get_node("Inbox").mail_add({"from": "ScannerServ", "subject": "Scanned Document", "body": scanner_interpret(text)})
	queue_free()
