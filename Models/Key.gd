extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum KeyType {SilverKey = 0, GoldKey = 1}

export(KeyType) var Key = KeyType.SilverKey

export(Color) var KeyColor


# Called when the node enters the scene tree for the first time.
func _ready():
	$Cube.set_surface_material(0, $Cube.get_surface_material(0).duplicate())
	$Cube.get_surface_material(0).albedo_color = KeyColor


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rotate_y(delta * 2.0)


func _on_KeyArea_body_entered(body):
	body.pick_up_key(Key)
