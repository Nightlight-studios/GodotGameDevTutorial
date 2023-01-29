extends KinematicBody2D

const Controls = preload("../Mechanics/Controls.gd")
const Time = preload("res://Assets/Scripts/Shared/Time.gd")

onready var animationPlayer = $AnimationPlayer

# Move variables
export var moveSpeed = 500
export var motion : Vector2 = Vector2()
const MOVEMENT_SMOOTHNESS = .9

# Player stats
const MAX_LIFE = 3
export var life = MAX_LIFE
export var coins = 0

# Player hurt 
const DAMAGE_COOLDOWN = .5
var last_damage_time = -1

# UI
var ui = null

## Code that executes when the player is ready
func _ready():
	ui = get_tree().get_root().find_node("UI", true, false)

## Code that executes once per update (60 times per second)
func _physics_process(_delta):
	
	## If scene reset
	if Input.is_action_pressed(Controls.RESET_LEVEL):
		var _ok = get_tree().reload_current_scene()
	
	move()

## Move The player
func move():
	motion = Vector2()
	
	## Right movement
	if Input.is_action_pressed(Controls.RIGHT):
		motion.x = lerp(motion.x,moveSpeed, MOVEMENT_SMOOTHNESS)
		animationPlayer.play("Right")
 
	## Left movement
	elif Input.is_action_pressed(Controls.LEFT):
		motion.x = -lerp(motion.x,moveSpeed, MOVEMENT_SMOOTHNESS)
		animationPlayer.play("Left")

	## Up movement
	elif Input.is_action_pressed(Controls.UP):
		motion.y = -lerp(motion.y,moveSpeed, MOVEMENT_SMOOTHNESS)
		animationPlayer.play("Up")
 
	## Down movement
	elif Input.is_action_pressed(Controls.DOWN):
		motion.y = lerp(motion.y,moveSpeed, MOVEMENT_SMOOTHNESS)
		animationPlayer.play("Down")
	else:
		animationPlayer.stop()
	
	motion = move_and_slide(motion, Vector2(0,0), false, 4, PI/4 ,false)

## Take damage
func take_damage(damage):	
	
	## If cooldown has not expired 
	if !damage_cooldown_has_passed(): 
		return
	
	## Damage the player
	life = life - damage
	ui.setHearts(life)
	last_damage_time = Time.current()
	
	if(life <= 0):
		var _ok = get_tree().change_scene("res://Assets/Scenes/Death.tscn")

## Get if the damage cooldown has passed
func damage_cooldown_has_passed():
	
	var time = Time.current()
	
	return time - last_damage_time > DAMAGE_COOLDOWN * 1000

## Add a coin to coin counter
func add_coin():
	coins += 1
	print("coin added")
	ui.setCoins(coins)
