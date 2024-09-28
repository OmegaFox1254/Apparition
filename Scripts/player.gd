extends CharacterBody2D

class_name player
@export var HEALTH:int = 100;
@export var FLASH:int = 100;
@export var pauseMenu:Control;
@export var controllable:bool = true;
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
var fpsTimer = 0


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		Engine.time_scale = !Engine.time_scale
		pauseMenu.visible = !pauseMenu.visible
		if !Engine.time_scale:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _physics_process(delta):
	if SPRINTAMMT <= 0:
		SPRINTOUT = true
	if SPRINTAMMT >= 100:
		SPRINTOUT = false
	if Input.is_action_pressed("Sprint") && controllable == true && SPRINTOUT == false && (Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")) != Vector2.ZERO):
		SPEED = SPRINTSPEED
		SPRINTAMMT-=3
	else:
		SPEED = WALKSPEED
		SPRINTAMMT+=float(SPRINTOUT)
		
	speedBar.value = SPRINTAMMT
	flashlightBar.value = FLASH
	healthBar.value = HEALTH
	var directionVector = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")).limit_length(4)
	
	if controllable:
		$Sprite2D.frame_coords = directionVector + Vector2(1, 1)

		if directionVector.x:
			velocity.x = directionVector.x * SPEED

		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		if directionVector.y:
			velocity.y = directionVector.y * SPEED

		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
