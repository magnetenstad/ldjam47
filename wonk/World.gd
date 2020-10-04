extends Node2D

onready var MAIN = get_parent()
onready var PLAYER = $Player

var velocity = Vector2()
var speed = 10
var speed_max = 60
var overlaps = []
var dir

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
		$Player/AnimatedSprite.animation = "idle"
	else:
		$Player/AnimatedSprite.animation = "walk"
		$Player/AnimatedSprite.flip_h = velocity.x < 0

func _physics_process(delta):
	if self.visible:
		get_input()
		velocity = PLAYER.move_and_slide(velocity)

func display_label(text):
	if text == "":
		$PanelContainer.visible = false
	else:
		if not $PanelContainer.visible:
			$PanelContainer.visible = true
		$PanelContainer/Label.text = text

func _process(delta):
	if self.visible:
		if "Desk" in overlaps:
			display_label("Computer (e)")
			if Input.is_action_pressed("interact"):
				MAIN.focus("Inbox")
		elif "LetterDesk" in overlaps:
			display_label("Letters (e)")
			if Input.is_action_pressed("interact"):
				MAIN.focus("Letter")
		elif "Grammophone" in overlaps:
			display_label("Toggle music (e)")
			if Input.is_action_pressed("interact"):
				print("Toggle music")
		else:
			display_label("")


func _on_DeskArea_area_entered(area):
	overlaps.append("Desk")



func _on_DeskArea_area_exited(area):
	overlaps.remove("Desk")


func _on_LetterDeskArea_area_entered(area):
	overlaps.append("LetterDesk")


func _on_LetterDeskArea_area_exited(area):
	overlaps.remove("LetterDesk")


func _on_GrammophoneArea_area_entered(area):
	overlaps.append("Grammophone")


func _on_GrammophoneArea_area_exited(area):
	overlaps.remove("Grammophone")
