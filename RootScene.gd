extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var spaceBarCount = 0

var Player
var Control2

var didLoadLevel = false

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.window_fullscreen = true
	Player = $Player
	remove_child(Player)
	
	Control2 = $Control2
	Control2.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
	if(didLoadLevel == false):
		if(Input.is_key_pressed(KEY_SPACE)):
			add_child(Player)
			remove_child($Control)


func _on_Level1_endGame():
	pass
