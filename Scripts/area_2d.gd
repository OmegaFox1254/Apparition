extends Area2D
@export var text:Label
@export var textBox:Control
@export var dialog:PackedStringArray
@export var currentPlayer:CharacterBody2D;
var dialouging = false;
var currentText = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body: Node2D) -> void:
	if body is player:
		dialouging = true
		textBox.visible = true;
		text.text = dialog[currentText];

func _input(event) -> void:
	if event is InputEventMouseButton and dialouging == true:
		if event.pressed:
			if currentText+1 < dialog.size():
				currentText+=1;
				text.text = dialog[currentText];
				
			else:
				dialouging = false;
				textBox.visible = false;
				$CollisionShape2D.disabled = true;
		
