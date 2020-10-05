extends PanelContainer
var cancel_f
var select1_f
var select2_f
var select3_f
var MAIN
var PF
var hover = false
var mouse_position = Vector2(0, 0)
var mouse_offset
var mouse_click = false

func _ready():
	self.set_position(Vector2(clamp(self.get_position().x, 384, 1546-500), clamp(self.get_position().y, 84, 732-300)))

func _process(_delta):
	if hover and mouse_click:
		self.set_position(mouse_position - mouse_offset)
		self.set_position(Vector2(clamp(self.get_position().x, 384, 1546-500), clamp(self.get_position().y, 84, 732-300)))
		
func set_variables(header, body, cancel, _cancel_f, select1, _select1_f, select2, _select2_f, select3, _select3_f):
	$VBoxContainer/PanelContainer/HBoxContainer2/Header.text = header
	$VBoxContainer/Body.text = body
	$VBoxContainer/PanelContainer/HBoxContainer2/CancelButton.text = cancel
	$VBoxContainer/HBoxContainer/Select1.text = select1
	$VBoxContainer/HBoxContainer/Select2.text = select2
	$VBoxContainer/Select3.text = select3
	
	cancel_f = _cancel_f
	select1_f = _select1_f
	select2_f = _select2_f
	select3_f = _select3_f


func close():
	MAIN.get_node("Inbox").PF.last_popup_x -= 10
	MAIN.get_node("Inbox").PF.last_popup_y -= 10
	queue_free()


func run_function(function):
	if "(" in function:
		var line = function.split("(")
		PF.callv(line[0], line[1].trim_suffix(")").split(","))
	elif function == "close":
		close()
	elif function == "":
		MAIN.get_node("ErrorSound").play()
	else:
		PF.call(function)

func _on_CancelButton_pressed():
	run_function(cancel_f)


func _on_Select1_pressed():
	run_function(select1_f)


func _on_Select2_pressed():
	run_function(select2_f)


func _on_Select3_pressed():
	run_function(select3_f)

func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = event.position
	elif event is InputEventMouseButton:
		if (event.is_pressed() and event.button_index == BUTTON_LEFT):
			mouse_click = true
			mouse_offset = mouse_position - self.get_position()
		else:
			mouse_click = false

func _on_PanelContainer_mouse_entered():
	hover = true

func _on_PanelContainer_mouse_exited():
	hover = false
