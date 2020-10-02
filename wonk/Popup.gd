extends PanelContainer
var cancel_f
var select1_f
var select2_f
var select3_f
var main

func set_variables(header, cancel, _cancel_f, select1, _select1_f, select2, _select2_f, select3, _select3_f):
	$VBoxContainer/PanelContainer/HBoxContainer2/Header.text = header
	$VBoxContainer/PanelContainer/HBoxContainer2/CancelButton.text = cancel
	$VBoxContainer/HBoxContainer/Select1.text = select1
	$VBoxContainer/HBoxContainer/Select2.text = select2
	$VBoxContainer/Select3.text = select3
	
	cancel_f = _cancel_f
	select1_f = _select1_f
	select2_f = _select2_f
	select3_f = _select3_f
	
	


func _on_CancelButton_pressed():
	main.call(cancel_f)
