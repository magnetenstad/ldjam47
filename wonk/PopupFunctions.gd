extends Node

const POPUP = preload("res://Popup.tscn")
var last_popup_x = 300
var last_popup_y = 0
var main

func _init(_main):
	main = _main

func popup_show(x, y, header, body, cancel, _cancel_f, select1, _select1_f, select2, _select2_f, select3, _select3_f):
	var popup = POPUP.instance()
	popup.set_variables(header, body, cancel, _cancel_f, select1, _select1_f, select2, _select2_f, select3, _select3_f)
	popup.set_position(Vector2(x, y))
	popup.main = main.PF
	main.add_child(popup)
	last_popup_x += 10
	last_popup_y += 10
	
func popup1():
	popup_show(last_popup_x, last_popup_y, "FREE ANTIVIRUS", "We have to you give free antivirus!!! defnitely remove all virus.", "X", "close", "get free", "trial", "do not get free", "buy(10)", "sign up", "popup_sign_up")

func popup_sign_up():
	popup_show(last_popup_x, last_popup_y, "SIGN UP", "Ah thank YOU FOr trying our product!! woo", "X", "close", "sign up with email", "buy(10)", "sign up with phone", "buy(10)", "do not sign up", "spam_sad")

func spam_sad():
	for i in range(10):
		popup_show(last_popup_x, last_popup_y, "WE're SAD TO SEE YOU GO", "why are you leaving", "X", "close", "", "", "", "", "", "")

func trial():
	# code for signing up for trial, autopay after 30 days
	pass
func buy(n):
	main.mail_add("J. Simpson", "Thank you for buying our product. Price: $" + str(n))
	main.add_balance(-float(n))
func spam():
	# func for sending 100 spam mails
	pass
