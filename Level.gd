extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var CurrentConfig = 1

var config1
var config2
var config3

signal endGame()

# Called when the node enters the scene tree for the first time.
func _ready():
	config1 = $Config1
	config2 = $Config2
	config3 = $Config3
	
	self.remove_child(config2)
	self.remove_child(config3)


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
			self.add_child(config1)
			self.remove_child(config2)
			self.remove_child(config3)
		4:
			self.add_child(config2)
			self.remove_child(config1)
			self.remove_child(config3)
		3:
			self.add_child(config3)
			self.remove_child(config1)
			self.remove_child(config2)
		4:
			self.remove_child(config1)
			self.remove_child(config2)
			self.remove_child(config3)


func _on_Portal1_teleported_signal(value):
	UpdateConfig(-1)


func _on_Portal2_teleported_signal(value):
	UpdateConfig(1)


func _on_Area_fallOffLedge():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var amount = rng.randi_range(-2,2)
	UpdateConfig(amount)


func _on_rope_LevelComplete():
	emit_signal("endGame")
