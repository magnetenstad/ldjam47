extends Node
var MAIN
var INBOX
var bitcoin_invest_state = -1
var letter
var word_list
var words_used = []

func _init(_main):
	MAIN = _main
	INBOX = MAIN.get_node("Inbox")
	word_list = MAIN.file_load("src/The_Oxford_3000.txt")
	print(word_list)
	
func cancel(subscription):
	if subscription in MAIN.subscriptions:
		MAIN.subscriptions.remove(subscription)
		MAIN.get_node("Inbox").mail_add({"from": subscription, "subject": "We're sorry to see you go.", "body": "You have cancelled your subscription of " + subscription + ". We welcome you back any time."})
	else:
		letter_queue("Your letter was received, but you are not subscribed to " + subscription + ". Please do not waste our time any more.")

func letter_queue(text):
	MAIN.incoming_letters.append(text)
	
func payment_queue(payment):
	MAIN.incoming_payments.append(payment)
	
func get_scammed_barithon():
	MAIN.add_balance(-1000)
	MAIN.subscription_add("Jones-Barithon Saxophone Shop")
	INBOX.mail_add(INBOX.content["Saxophone"])
	
func bitcoin_invest(state):
	state = int(state)
	var chapman_signature = "\n\nBest regards,\nH. Chapman\n\nRemember: Include your name, my address (Telegraph Tower, New York), the sum and the keyword bitcoin!"
	if bitcoin_invest_state == state-1:
		bitcoin_invest_state += 1
		match state:
			0:
				payment_queue(-250)
				letter_queue("Thank you for your payment, Aretha! Since I received your payment this week, your balance has already tripled. However, to withdraw your money the balance must be over $900. Please send an additional $150 to be able to withdraw your money." + chapman_signature)
			1:
				payment_queue(-150)
				letter_queue("Thank you for the payment. The bitcoin market is volatile, and the balance of your account is now $500. (Still $100 more than you started with!) Please send an additional $400." + chapman_signature)
			2:
				payment_queue(-400)
				letter_queue("Dear Aretha. Since the medical resurrection of oil baron V.W.Keishlinger, the markets have been completely wild. I must inform you that my initial purpose was to scam you of money, however, with the current state of the markets, your deposits have given me enormous wealth. Your investment is now worth $500k dollars. I am no kind man, but as a honor to your goodwill I will give you back $6000. However, I need another $1000 to pay for the plane ticket out of my remote village so that I can visit a bank. If you send me this money, I will send you your $1000.\n\nBest regards, Ajit Champan\n\nYou can send the money to the usual adress - Telegraph Tower, New York. Include your name and the amount - $1000 plus the usual keyword 'bitcoin'.")
			3:
				payment_queue(6000)
				letter_queue("Dear Aretha. I have transferred the money. Because of you, I am able to stop scamming people in the west for money. Good luck on your journey.\n\nAjit Champan")
	else:
		letter_queue("Hello Aretha, I believe you might have sent me the wrong sum. I could not cash in your sum, so please try again" + chapman_signature)

func article_review():
	var score = 0
	for word in letter.split(" "):
		if word in word_list and not word in words_used:
			score += pow(len(word), 2)
			words_used.append(word)
	score = min(score, 1000)
	letter_queue("Hello Aretha, Thank you for your latest articles. You have been awarded $" + str(score) + ".")
	payment_queue(score)
	
