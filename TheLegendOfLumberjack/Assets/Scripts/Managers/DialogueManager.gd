extends Node2D

const Constants = preload("res://Assets/Scripts/Shared/Constants.gd")

var current;

func _ready():
	
	var context = get_tree().get_current_scene().get_name()
	var path = Constants.DILOGUE_FILE_TEMPLATE.replace("$file",context);
	print(path)
	
	# Check if file exists
	var file = File.new()
	if not file.file_exists(path):
		
		## Load error scene
		print("ERROR READING DIALOGUE FILE!")
		get_tree().change_scene(Constants.ERROR)
		return
	
	# Read current data
	file.open(path, File.READ)
	print(file.get_as_text())
	current = parse_json(file.get_as_text())	
	pass

## Get the requested dialogue
func get_dialog(objectID,dialogueID): 
	
	print(objectID)
	
	if not objectID in current:
		return "..."
	
	if not dialogueID in current[objectID]:
		return "..."
	
	return current[objectID][dialogueID]
