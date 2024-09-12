extends CharacterBody2D


var SPEED = 100.0
const SPRINTSPEED = 150.0
const WALKSPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	if Input.is_action_pressed("Sprint"):
		SPEED = SPRINTSPEED
	else:
		SPEED = WALKSPEED
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	#Get the input from WASD and arrows, then normalize the vector
	var directionVector = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")).limit_length()
	
	if directionVector.x:
		#Apply movement on the X axis
		velocity.x = directionVector.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if directionVector.y:
		#Apply movement on the Y axis
		velocity.y = directionVector.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	
	move_and_slide()
