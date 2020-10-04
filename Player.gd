extends KinematicBody

const GRAVITY = -24.8
var vel = Vector3()
const MAX_SPEED = 6
const JUMP_SPEED = 10
const ACCEL = 7

var dir = Vector3()

const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40

var camera
var rotation_helper

var MOUSE_SENSITIVITY = 0.1

#footstep vars
var footstepTimeElapsed = 0.0
var footstepDelay = 0.4

var bSilverKey = false
var bGoldKey = false

var landing : bool
var bRopeClimb = false

func _ready():
	camera = $Camera
#	rotation_helper = transform

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):	
	process_audio(delta)
	process_input()
	
	if(bRopeClimb):
		move_and_slide(Vector3(0,20 * delta, 0), Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))
		return
		
	process_movement(delta)	

func process_input():
	if Input.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	# ----------------------------------
	# Walking
	dir = Vector3()
	var cam_xform = camera.get_global_transform()

	var input_movement_vector = Vector2()

	if Input.is_action_pressed("movement_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("movement_backward"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("movement_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("movement_right"):
		input_movement_vector.x += 1

	input_movement_vector = input_movement_vector.normalized()

	# Basis vectors are already normalized.
	dir += -global_transform.basis.z * input_movement_vector.y
	dir += global_transform.basis.x * input_movement_vector.x
	# ----------------------------------

	# ----------------------------------
	# Jumping
	var isGrounded = $RayCast.is_colliding()
	if isGrounded:
		if Input.is_action_just_pressed("movement_jump"):
			vel.y = JUMP_SPEED
			$JumpPlayer.play()
	# ----------------------------------

	# ----------------------------------
	# Capturing/Freeing the cursor
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# ----------------------------------

func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta * GRAVITY

	var hvel = vel
	hvel.y = 0

	var target = dir
	target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z

	vel = move_and_slide(vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
#		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))
		#self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

#		var camera_rot = self.rotation_degrees
#		camera_rot.x = clamp(camera_rot.x, -70, 70)
		
		camera.rotation_degrees.x -= event.relative.y * MOUSE_SENSITIVITY
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -89, 89)
		self.rotation_degrees.y -= event.relative.x * MOUSE_SENSITIVITY

func process_audio(delta):
	
	var isGrounded = $RayCast.is_colliding()
	
	if(!isGrounded || abs(vel.length()) < 0.5):
		footstepTimeElapsed = 0.0
	else:
		footstepTimeElapsed += delta
	
	if(footstepTimeElapsed >= footstepDelay):
		$FootstepPlayer.play(0.0)
		footstepTimeElapsed = 0.0
		
	if isGrounded:
		if landing:
			print_debug(vel)
			$LandPlayer.play()
			landing = false
	else:
		if !landing:
			landing = true
			#print_debug(vel)
			
func pick_up_key(type):
	print_debug("key picked up: " + str(type) )
	if type == 0:
		bSilverKey = true
		$Control/SilverKeyImg.visible = true
	elif type == 1:
		bGoldKey = true
		$Control/GoldKeyImg.visible = true

func climbRope():
	bRopeClimb = true

func needSilver():
	$Control/NeedSilverText.visible = true
func needGold():
	$Control/NeedGoldText.visible = true

func hideKeyText():
	$Control/NeedGoldText.visible = false
	$Control/NeedSilverText.visible = false
