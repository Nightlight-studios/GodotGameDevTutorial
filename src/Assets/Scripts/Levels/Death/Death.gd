extends Node2D

onready var camera = $Camera2D


func _physics_process(delta):
	
	var zoomX = lerp(camera.zoom.x , camera.zoom.x -.2, .2);
	var zoomY = lerp(camera.zoom.y, camera.zoom.y -.2,.2);
	
	if(zoomX > 1):
		camera.zoom = Vector2(zoomX, zoomY);
	
	
	if(Input.is_action_pressed("ui_accept")):
		var _ok = get_tree().change_scene("res://Assets/Scenes/StartMenu.tscn")
	
