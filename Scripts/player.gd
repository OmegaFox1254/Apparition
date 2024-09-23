extends CharacterBody2D


@export var HEALTH:int = 100;
@export var FLASH:int = 100;
@export_category("bars")
@export var speedBar:TextureProgressBar;
@export var flashlightBar:TextureProgressBar;
@export var healthBar:TextureProgressBar;

@export_category("speed")
@export var SPRINTSPEED:float = 150.0;
@export var WALKSPEED:float = 100.0;
@export var SPRINTAMMT:float = 100.0;

var SPEED:float = 100.0;
var SPRINTOUT:bool = false;
const JUMP_VELOCITY:float = -400.0;



var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if SPRINTAMMT <= 0:
		SPRINTOUT = true
	if SPRINTAMMT >= 100:
		SPRINTOUT = false
<<<<<<< HEAD
	if Input.is_action_pressed("Sprint") && SPRINTOUT == false && (Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")) != Vector2.ZERO):
=======
	if Input.is_action_pressed("Sprint") && SPRINTOUT == false:
>>>>>>> 6df03f3babd4fa7901af36f7d4d4527749c65667
		SPEED = SPRINTSPEED
		SPRINTAMMT-=3
	else:
		SPEED = WALKSPEED
		SPRINTAMMT+=float(SPRINTOUT)
		
	speedBar.value = SPRINTAMMT
	flashlightBar.value = FLASH
	healthBar.value = HEALTH

	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	var directionVector = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")).limit_length(4)
	$Sprite2D.frame_coords = directionVector + Vector2(1, 1)
	print($Sprite2D.frame_coords)
	if directionVector.x:

		velocity.x = directionVector.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if directionVector.y:

		velocity.y = directionVector.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	
	move_and_slide()
