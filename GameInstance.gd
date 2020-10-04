extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var GameLevel
var GameIntro
var GameExit

# Called when the node enters the scene tree for the first time.
func _ready():
	var GameLevel = $GameTop
	remove_child(GameLevel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		var x = $GameTop
		self.add_child(GameLevel)
