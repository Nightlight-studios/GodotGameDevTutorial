extends KinematicBody2D

onready var interactIcon = $InteractIcon
onready var animationPlayer = $AnimationPlayer

var ui;
var dialogManager;

# Talk states
const DIALOGUE_STATES = [
	"Hello",
	"Love"
]
var state : String;

func _ready():
	ui = get_tree().get_root().find_node("UI", true, false)
	dialogManager = get_tree().get_root().find_node("DialogueManager", true, false)
	setState("Hello")

## Interact with the NPC
func interact(player):
	
	print(state)
	
	# if NoMoreDialogs():
	#	player.setMovementOn()
	#	ui.hideDialogue()
	#	return
	
	player.setMovementOff()
	if dialogManager == null:
		return 
			
	var dialogue = dialogManager.get_dialog(self.name, state)
	
	if ui != null:
		ui.setDialogue(dialogue)
	
	print(dialogue)
	
## Show the interaction icon
func showInteractIcon():
	interactIcon.show()
	animationPlayer.play("IdleIcon")

## Hide the interaction icon
func hideInteractIcon():
	interactIcon.hide()
	animationPlayer.stop()

## Set state 
func setState(name):
	
	var index = DIALOGUE_STATES.find(name)	
	
	if index == -1:
		return 
	
	state = DIALOGUE_STATES[index]
