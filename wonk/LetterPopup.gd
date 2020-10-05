extends Node2D

var MAIN
var text
var hover = false
var mouse_position = Vector2(0, 0)
var mouse_offset
var mouse_click = false

func _process(_delta):
	if hover and mouse_click:
		self.set_position(mouse_position - mouse_offset)
		self.set_position(Vector2(clamp(self.get_position().x, 0, 1920-768), clamp(self.get_position().y, 0, 1080-576)))

func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = event.position
	elif event is InputEventMouseButton:
		if (event.is_pressed() and event.button_index == BUTTON_LEFT):
			mouse_click = true
			mouse_offset = mouse_position - self.get_position()
		else:
			mouse_click = false

func _on_Body_mouse_entered():
	hover = true

func _on_Body_mouse_exited():
	hover = false

func scanner_interpret(text):
	var new_text = "The scanner has attempted to interpret your document.\n\n---\n\n"
	for letter in text:
		if rand_range(0, 1) > 0.92:
			new_text += "?"
		else:
			new_text += letter
	new_text += "\n\n---"
	return new_text

func _on_ButtonScanner_pressed():
	MAIN.get_node("Inbox").mail_add({"from": "ScannerServ", "subject": "Scanned Document", "body": scanner_interpret(text)})
	queue_free()


func _on_ButtonGarbage_pressed():
	queue_free()
