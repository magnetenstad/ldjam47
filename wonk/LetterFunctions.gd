extends Node
var MAIN

func _init(_main):
	MAIN = _main
	
func cancel(subscription):
	MAIN.subscriptions.remove(subscription)
	MAIN.mail_add({"from": subscription, "subject": "We're sorry to see you go.", "body": "You have cancelled your subscription of " + subscription + ". We welcome you back any time."})
