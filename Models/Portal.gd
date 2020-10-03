extends Spatial


export(NodePath) var OTHER_PORTAL
onready var portalRef = get_node(OTHER_PORTAL)

export var incrementAmount = 0

signal teleported_signal(value)

func levelChange():
	emit_signal("teleported_signal", incrementAmount)
