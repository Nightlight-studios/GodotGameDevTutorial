extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	
	if(Input.is_action_pressed("ui_start")):
		var _ok = get_tree().change_scene("res://Assets/Scenes/Home.tscn")
