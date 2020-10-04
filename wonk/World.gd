extends Node2D

onready var MAIN = get_parent()
onready var PLAYER = $YSort/Player

var velocity = Vector2()
var speed = 10
var speed_max = 60
var overlaps = []
const PHYSICAL_LETTER = preload("res://PhysicalLetter.tscn")

func _ready():
	pass

func get_input():
	var temp = velocity.x
	if Input.is_action_pressed('right'):
		velocity.x = min(speed_max, velocity.x + speed)
	if Input.is_action_pressed('left'):
		velocity.x = max(-speed_max, velocity.x - speed)
	if velocity.x == temp:
		velocity.x *= 0.8

	temp = velocity.y
	if Input.is_action_pressed('down'):
		velocity.y = min(speed_max, velocity.y + speed)
	if Input.is_action_pressed('up'):
		velocity.y = max(-speed_max, velocity.y - speed)
	if velocity.y == temp:
		velocity.y *= 0.8

	if velocity.length() < 10:
		$YSort/Player/AnimatedSprite.animation = "idle"
	else:
		$YSort/Player/AnimatedSprite.animation = "walk"
		$YSort/Player/AnimatedSprite.flip_h = velocity.x < 0

func _physics_process(delta):
	if self.visible:
		get_input()
		velocity = PLAYER.move_and_slide(velocity)
		PLAYER.position.x = clamp(PLAYER.position.x, 0 + 12, 320 - 12)
		PLAYER.position.y = clamp(PLAYER.position.y, 0 + 3 * 16 - 8, 180 - 24)

func display_label(text):
	if text == "":
		$PanelContainer.visible = false
	else:
		if not $PanelContainer.visible:
			$PanelContainer.visible = true
		$PanelContainer/Label.text = text

func get_letters_from_overlapping_dict(dict):
	var letters = []
	for element in dict.keys():
		if element.find("PhysicalLetterArea") != -1:
			letters.append(dict[element])
	if len(letters) == 0:
		return false
	return letters

func interacts(event):
	if event.is_action_pressed("interact"):
		return true

func _input(event):
	if self.visible:
		var overlapping_objects = $YSort/Player/PlayerArea.get_overlapping_areas()
		var overlaps = {}
		for o in overlapping_objects:
			overlaps[o.name] = o
		if "DeskArea" in overlaps.keys() and interacts(event):
			MAIN.focus("Inbox")
		elif "LetterDeskArea" in overlaps.keys() and interacts(event):
			MAIN.focus("Letter")
		elif "GrammophoneArea" in overlaps.keys() and interacts(event):
			print("Toggle music")
		elif get_letters_from_overlapping_dict(overlaps) and interacts(event):
			var letters = get_letters_from_overlapping_dict(overlaps)
			print(letters[0].get_parent().text)
			letters[0].get_parent().queue_free()

func _process(delta):
	if self.visible:
		var overlapping_objects = $YSort/Player/PlayerArea.get_overlapping_areas()
		var overlaps = {}
		for o in overlapping_objects:
			overlaps[o.name] = o

		if "DeskArea" in overlaps.keys():
			display_label("Computer (e)")
		elif "LetterDeskArea" in overlaps.keys():
			display_label("Letters (e)")
		elif "GrammophoneArea" in overlaps.keys():
			display_label("Toggle music (e)")
		elif get_letters_from_overlapping_dict(overlaps):
			display_label("Read letter (e)")
		else:
			display_label("")

func letter_receive(text):
	var physical_letter = PHYSICAL_LETTER.instance()
	physical_letter.text = text
	self.add_child(physical_letter)
	physical_letter.position = Vector2(160, 160)
