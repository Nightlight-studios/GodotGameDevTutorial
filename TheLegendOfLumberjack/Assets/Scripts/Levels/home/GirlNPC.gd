extends KinematicBody2D

onready var interactIcon = $InteractIcon
onready var animationPlayer = $AnimationPlayer

var ui;

func _ready():
	ui = get_tree().get_root().find_node("UI", true, false)

func interact():
	if ui != null:
		ui.setDialogue("hello dad!")
	
	print("Hello dad!")

func showInteractIcon():
	interactIcon.show()
	animationPlayer.play("IdleIcon")

func hideInteractIcon():
	interactIcon.hide()
	animationPlayer.stop()
