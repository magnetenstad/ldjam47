extends StaticBody2D

var WORLD
var text = ""
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.


func _ready():
	rotate(rand_range(0, 100)/(50*PI))
	WORLD = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
