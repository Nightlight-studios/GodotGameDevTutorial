extends Node2D

onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("Idle")


func _on_Area2D_body_entered(body):
	
	if("Player" == body.get_name()):
		body.add_coin();
		queue_free();
