extends KinematicBody2D

const Controls = preload("res://Assets/Scripts/Mechanics/Controls.gd")
const Direction = preload("res://Assets/Scripts/Mechanics/Direction.gd")
const Time = preload("res://Assets/Scripts/Shared/Time.gd")

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var hurtbox = $AttackBox/CollisionShape2D

# Move variables
export var moveSpeed = 500
export var motion : Vector2 = Vector2()
export var direction : int = Direction.DOWN
const MOVEMENT_SMOOTHNESS = .9

# Player stats
const MAX_LIFE = 3
export var life = MAX_LIFE
export var coins = 0

# Player hurt 
const DAMAGE_COOLDOWN = .5
var last_damage_time = -1

## Player attack
export var player_attack_power = 1;
var attackable_enemies = []

## Player interact
var interactable_objects = []

# UI
var ui = null
const TILESET_WIDTH = 4

## Code that executes when the player is ready
func _ready():
	ui = get_tree().get_root().find_node("UI", true, false)

## Code that executes once per update (60 times per second)
func _physics_process(_delta):
	
	## If scene reset
	if Input.is_action_pressed(Controls.RESET_LEVEL):
		var _ok = get_tree().reload_current_scene()
	
	move()
	interact()
	attack()

## Move The player
func move():
	motion = Vector2()
	
	var is_movement_just_released = Input.is_action_just_released(Controls.RIGHT) || Input.is_action_just_released(Controls.LEFT) || Input.is_action_just_released(Controls.UP) || Input.is_action_just_released(Controls.DOWN)
	if is_movement_just_released:
		reset_to_idle()
	
	
	var is_movement_active = Input.is_action_pressed(Controls.RIGHT) || Input.is_action_pressed(Controls.LEFT) || Input.is_action_pressed(Controls.UP) || Input.is_action_pressed(Controls.DOWN)
	if !is_movement_active:
		return
	
	## Right movement
	if Input.is_action_pressed(Controls.RIGHT):
		motion.x = lerp(motion.x,moveSpeed, MOVEMENT_SMOOTHNESS)
		animationPlayer.play("Right")
		hurtbox.position = Vector2(70,0)
		direction = Direction.RIGHT
 
	## Left movement
	elif Input.is_action_pressed(Controls.LEFT):
		motion.x = -lerp(motion.x,moveSpeed, MOVEMENT_SMOOTHNESS)
		animationPlayer.play("Left")
		hurtbox.position = Vector2(-70,0)
		direction = Direction.LEFT

	## Up movement
	elif Input.is_action_pressed(Controls.UP):
		motion.y = -lerp(motion.y,moveSpeed, MOVEMENT_SMOOTHNESS)
		animationPlayer.play("Up")
		hurtbox.position = Vector2(0,-100)
		direction = Direction.UP
 
	## Down movement
	elif Input.is_action_pressed(Controls.DOWN):
		motion.y = lerp(motion.y,moveSpeed, MOVEMENT_SMOOTHNESS)
		animationPlayer.play("Down")
		hurtbox.position = Vector2(0,100)
		direction = Direction.DOWN		
	
	motion = move_and_slide(motion, Vector2(0,0), false, 4, PI/4 ,false)

## Attack with player
func attack():
	if Input.is_action_just_pressed("ui_accept"):
		match direction:
			Direction.DOWN:
				sprite.frame = TILESET_WIDTH - 1
			Direction.UP:
				sprite.frame = TILESET_WIDTH * 2 - 1
			Direction.LEFT:
				sprite.frame = TILESET_WIDTH * 3 - 1
			Direction.RIGHT:
				sprite.frame = TILESET_WIDTH * 3 - 1
			
		for enemy in attackable_enemies:
			enemy.take_damage(player_attack_power)
			
	if Input.is_action_just_released("ui_accept"):
		reset_to_idle()

func interact():
	if Input.is_action_just_pressed("ui_accept") && !interactable_objects.empty():
		interactable_objects[0].interact()

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

## Reset to Idle frame  
func reset_to_idle():
	
	if sprite.scale.x > 0:
		sprite.scale.x = -sprite.scale.x 
	
	match direction:
		Direction.DOWN:
			sprite.frame = 0
		Direction.UP:
			sprite.frame = TILESET_WIDTH
		Direction.LEFT:
			sprite.frame = TILESET_WIDTH * 2
		Direction.RIGHT:
			sprite.frame = TILESET_WIDTH * 2
			if sprite.scale.x < 0:
				sprite.scale.x = -sprite.scale.x 

func _on_AttackBox_body_entered(body):
	if body.name == "Crab":
		attackable_enemies.append(body)
		
	if body.is_in_group("Interactable"):
		body.showInteractIcon()
		interactable_objects.append(body)


func _on_AttackBox_body_exited(body):
	if body.name == "Crab":
		attackable_enemies.remove(attackable_enemies.find(body))

	if body.is_in_group("Interactable"):
		body.hideInteractIcon()
		interactable_objects.remove(interactable_objects.find(body))
