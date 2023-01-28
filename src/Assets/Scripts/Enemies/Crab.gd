extends KinematicBody2D

const Controls = preload("../Mechanics/Controls.gd");
const Direction = preload("../Mechanics/Direction.gd")

onready var animationPlayer = $AnimationPlayer

# Movement constants
const moveSpeed = 250;

# Motion states
var motion : Vector2 = Vector2();
var moving = true
var step = 0;
var last_time = 0;

# Movement patterns 
const pattern = [
	Direction.DOWN, 
	Direction.NONE, 
	Direction.RIGHT,
	Direction.NONE, 
	Direction.RIGHT, 
	Direction.NONE, 
	Direction.UP, 
	Direction.NONE, 
	Direction.RIGHT,
	Direction.NONE,  
	Direction.DOWN, 
	Direction.NONE, 
	Direction.LEFT, 
	Direction.NONE, 
	Direction.LEFT, 
	Direction.NONE, 
	Direction.UP,
	Direction.NONE, 
]

func _ready():
	animationPlayer.play("Move")

func _physics_process(_delta):
	
	if !moving:
		return
			
	var time = current_time()
	
	if(is_first_time()):
		last_time = current_time()
	
	if(time_has_passed(time)):
		step += 1;
		last_time = current_time()
		
		if(pattern.size() <= step):
			step = 0;

	
	motion = Vector2()	
	
	match pattern[step]: 
		Direction.UP:
			motion.y = -lerp(motion.y,moveSpeed,.9)
		
		Direction.DOWN:
			motion.y = lerp(motion.y,moveSpeed,.9);
			
		Direction.LEFT:
			motion.x = -lerp(motion.x,moveSpeed,.9);
			
		Direction.RIGHT:
			motion.x = lerp(motion.x,moveSpeed,.9);
	
	motion = move_and_slide(motion, Vector2(0,-1), false, 4, PI/4 ,false);

func is_first_time():
	return last_time == -1;

func current_time():
	return OS.get_system_time_msecs();
	
func time_has_passed(time):
	return time - last_time > 1000
	
func _on_Area2D_body_entered(body):

	if(body.name == "Player"):
		body.take_damage(.5)
