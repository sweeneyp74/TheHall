extends Area


var portal


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PortalTeleportArea_body_entered(body):
	var parent = get_parent()
	print_debug(parent.portalRef)
	var otherPortal = parent.portalRef

	var teleportVector = otherPortal.get_node("TeleportLocation").global_transform.origin
	body.global_transform.origin = teleportVector
	
	#var rng = RandomNumberGenerator.new()
	$PortalSound.pitch_scale = 2
	$PortalSound.play(0.0)
	
	parent.levelChange()
	
