extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum KeyType {SilverKey = 0, GoldKey = 1}
export(KeyType) var Key = KeyType.SilverKey

var bPlayedAnimation = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	
	if(bPlayedAnimation):
		return
	
	if Key == KeyType.SilverKey:
		if body.bSilverKey:
			print_debug("silver key! opening")
			$AnimationPlayer.play("GateOpen")
			$GateSound.play()
			bPlayedAnimation = true
		else:
			body.needSilver()
	if Key == KeyType.GoldKey:
		if body.bGoldKey:
			print_debug("gold key! opening")
			$AnimationPlayer.play("GateOpen")
			$GateSound.play()
			bPlayedAnimation = true
		else:
			body.needGold()
		


func _on_Area_body_exited(body):
	body.hideKeyText()
