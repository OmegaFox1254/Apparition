extends Area2D
@export var text:Label
@export var textBox:Control
@export var anchor:Control
@export var dialog:PackedStringArray
@export var playerIsTalking:Array[bool]
@export var currentPlayer:CharacterBody2D
@export var deathAnimationTalk:AnimationPlayer
@export var ghostAnimationTalk:AnimationPlayer

@export var variationMin:float = 0.9;
@export var variationMax:float = 1.1;

var dialouging = false;
var speaking = false;
var currentText = 0;

var currentTime:float = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body: Node2D) -> void:
	currentText = 0;
	if body is player:
		dialouging = true
		textBox.visible = true;
		text.text = "";
		for i in dialog[currentText]:
			speaking = true;
			text.text += i;
			if(playerIsTalking[currentText]==true):
				textBox.get_node("DeathPortrait").get_node("AudioStreamPlayer").playing = true;
			else:
				textBox.get_node("GhostPortrait").get_node("AudioStreamPlayer").pitch_scale = randf_range(variationMin, variationMax);
				textBox.get_node("GhostPortrait").get_node("AudioStreamPlayer").playing = true;
			await get_tree().create_timer(0.04).timeout;
		speaking = false;
		
		if playerIsTalking[currentText] == true:
			anchor.get_node("GhostPortrait").modulate = Color8(255, 255, 255, 73);
			textBox.get_node("DeathPortrait").modulate = Color8(255, 255, 255, 255);
		else:
			textBox.get_node("GhostPortrait").modulate = Color8(255, 255, 255, 255);
			textBox.get_node("DeathPortrait").modulate = Color8(255, 255, 255, 73);
			
			

func _input(_event) -> void:
	var Interacting = Input.is_action_just_pressed("Interact")
	if Interacting and dialouging == true and speaking == false:
		if currentText+1 < dialog.size():
			currentText+=1;
			if playerIsTalking[currentText] == true && playerIsTalking[currentText-1]==false:
				deathAnimationTalk.play_backwards("dim");
				ghostAnimationTalk.play("dim");
			elif playerIsTalking[currentText]==false && playerIsTalking[currentText-1]==true:
				deathAnimationTalk.play("dim");
				ghostAnimationTalk.play_backwards("dim");
			
			text.text = "";
			for i in dialog[currentText]:
				speaking = true;
				text.text += i;
				if(playerIsTalking[currentText]==true):
					textBox.get_node("DeathPortrait").get_node("AudioStreamPlayer").playing = true;
				else:
					anchor.get_node("GhostPortrait").get_node("AudioStreamPlayer").pitch_scale = randf_range(variationMin, variationMax);
					anchor.get_node("GhostPortrait").get_node("AudioStreamPlayer").playing = true;
				await get_tree().create_timer(0.04).timeout;
			speaking = false;
		else:
			dialouging = false;
			textBox.visible = false;
