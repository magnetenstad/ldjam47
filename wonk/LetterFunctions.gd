extends Node
var MAIN

func _init(_main):
	MAIN = _main
	
func cancel(subscription):
	if subscription in MAIN.subscriptions:
		MAIN.subscriptions.remove(subscription)
		MAIN.get_node("Inbox").mail_add({"from": subscription, "subject": "We're sorry to see you go.", "body": "You have cancelled your subscription of " + subscription + ". We welcome you back any time."})
	else:
		mail_queue("Your letter was received, but you are not subscribed to " + subscription + ". Please do not waste our time any more.")
func mail_queue(text):
	MAIN.incoming_mail.append(text)
