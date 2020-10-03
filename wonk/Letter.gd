extends Control

onready var MAIN = get_parent()

func _ready():
	pass
	
func _on_ButtonDiscard_pressed():
	MAIN.focus("World")
	
