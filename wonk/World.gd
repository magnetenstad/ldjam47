extends Node2D
onready var PLAYER = $Player
var velocity = Vector2()
var speed = 100
onready var MAIN = get_parent()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var overlaps = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_input():
	if self.visible:
		velocity = Vector2.ZERO
		if Input.is_action_pressed('right'):
			velocity.x += 1
		if Input.is_action_pressed('left'):
			velocity.x -= 1
		if Input.is_action_pressed('down'):
			velocity.y += 1
		if Input.is_action_pressed('up'):
			velocity.y -= 1
		velocity = velocity.normalized() * speed

func _physics_process(delta):
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
