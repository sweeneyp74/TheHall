extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal LevelComplete()

# Called when the node enters the scene tree for the first time.
func _ready():
#	self.visible = true
#	$Area/CollisionShape.disabled = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	print_debug("rope touched")
	body.climbRope()
	$RopeNoise.play()
	$Timer.start()


func _on_Treasure_treasureSignal():
	self.visible = true
	$Area/CollisionShape.disabled = false
	#emit_signal("LevelComplete")


func _on_Timer_timeout():
	$RopeNoise.stop()
	emit_signal("LevelComplete")
