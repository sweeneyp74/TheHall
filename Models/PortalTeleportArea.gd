extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var portal

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_PortalTeleportArea_body_entered(body):
	var parent = get_parent()
	print_debug(parent.portalRef)
	var otherPortal = parent.portalRef

	var teleportVector = otherPortal.get_node("TeleportLocation").global_transform.origin
	
	body.global_transform.origin = teleportVector
#	print_debug(parent.LevelToTeleportTo)
#	print_debug("Exit? " + str(parent.isExit))
	
