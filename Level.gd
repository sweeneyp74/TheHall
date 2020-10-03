extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var CurrentConfig = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func UpdateConfig(value):
	CurrentConfig += value
	
	if(CurrentConfig > 4):
		CurrentConfig = 1
	if(CurrentConfig < 1):
		CurrentConfig = 4
	
	match CurrentConfig:
		1:
			print("level 1")
		2:
			print("level 2")
		3:
			print("level 3")
		4:
			print("level 4")


func _on_Portal1_teleported_signal(value):
	UpdateConfig(-1)


func _on_Portal2_teleported_signal(value):
	UpdateConfig(1)
