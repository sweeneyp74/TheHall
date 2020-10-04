extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal treasureSignal()

var yOrigin = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	yOrigin = $Cone.global_transform.origin.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Cone.global_transform.origin.y = yOrigin + (sin(.001 * OS.get_ticks_msec()) / 3)
	#print_debug(sin(.01 * delta))


func _on_Area_body_entered(body):
	$TreasureSound.play()
	$Cone.visible = false
	$Area/CollisionShape.disabled = true
	emit_signal("treasureSignal")
