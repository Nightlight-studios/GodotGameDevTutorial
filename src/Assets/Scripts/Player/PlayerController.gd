extends KinematicBody2D

const Controls = preload("../Mechanics/Controls.gd");

# Move variables
export var moveSpeed = 500
export var motion : Vector2 = Vector2()

## Player stats
const MAX_LIFE = 3;
export var life = MAX_LIFE;

var ui = null

func _ready():
	ui = get_tree().get_root().find_node("UI", true, false);


func _physics_process(_delta):
	
	motion = Vector2()
	
	## If scene reset
	if Input.is_action_pressed(Controls.RESET_LEVEL):
		var _ok = get_tree().reload_current_scene();
		
	## Right movement
	if Input.is_action_pressed(Controls.RIGHT):
		motion.x = moveSpeed;
 
	## Left movement
	if Input.is_action_pressed(Controls.LEFT):
		motion.x = -moveSpeed;

	## Up movement
	if Input.is_action_pressed(Controls.UP):
		motion.y = -moveSpeed;
 
	## Down movement
	if Input.is_action_pressed(Controls.DOWN):
		motion.y = +moveSpeed;

	motion = move_and_slide(motion,Vector2(0,-1), false, 4, PI/4 ,false);

func take_damage(damage):	
	
	life = life - damage;
	ui.setHearts(life);
	
	if(life <= 0):
		var _ok = get_tree().change_scene("res://Assets/Scenes/Death.tscn")
