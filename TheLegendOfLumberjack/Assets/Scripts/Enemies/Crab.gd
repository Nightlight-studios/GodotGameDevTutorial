extends KinematicBody2D

const Controls = preload("res://Assets/Scripts/Mechanics/Controls.gd")
const Direction = preload("res://Assets/Scripts/Mechanics/Direction.gd")
const Time = preload("res://Assets/Scripts/Shared/Time.gd")

onready var animationPlayer = $AnimationPlayer

# Movement constants
const MOVE_SPEED = 250
const MOVE_TIME = 1;
const MOTION_SMOOTHNESS = .9

# Motion states
var motion : Vector2 = Vector2()
var moving = true
var step = 0
var last_moving_time = -1

# Player hurting values
const CRAB_IDLE_DAMAGE = .5;
var players = []

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

## Code that executes when crab is ready
func _ready():
	animationPlayer.play("Move")

## Code that executes once per update (60 times per second)
func _physics_process(_delta):
	move()
	check_damage()	
	
## Code that executes when a body entered crab's area
func _on_Area2D_body_entered(body):

	if(body.name == "Player"):
		players.append(body)

## Code that executes when a body lives crab's area
func _on_Area2D_body_exited(body):
	
	if(body.name == "Player"):
		players.remove(players.find(body))

## Crab movement logic
func move():
	
	if !moving:
		return
			
	var time = Time.current()
	
	if(is_fist_time_moving()):
		last_moving_time = Time.current()
	
	if(move_time_has_passed(time)):
		step += 1
		last_moving_time = Time.current()
		
		if(pattern.size() <= step):
			step = 0

	motion = Vector2()	
	
	match pattern[step]: 
		Direction.UP:
			motion.y = -lerp(motion.y,MOVE_SPEED,.9)
		
		Direction.DOWN:
			motion.y = lerp(motion.y,MOVE_SPEED,.9)
			
		Direction.LEFT:
			motion.x = -lerp(motion.x,MOVE_SPEED,.9)
			
		Direction.RIGHT:
			motion.x = lerp(motion.x,MOVE_SPEED,.9)
	
	motion = move_and_slide(motion, Vector2(0,-1), false, 4, PI/4 ,false)
	pass

## Get if it is the first time moving
func is_fist_time_moving():
	return last_moving_time == -1
	
## Get if the moving time has passed
func move_time_has_passed(time):
	return time - last_moving_time > MOVE_TIME * 1000

## Check if damage has to be done to colliding players
func check_damage():
	
	for player in players:
		player.take_damage(CRAB_IDLE_DAMAGE)

