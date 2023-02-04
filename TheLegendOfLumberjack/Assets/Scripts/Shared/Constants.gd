extends Node

## DIALOGUES -----------------------------------------
const DILOGUE_FILE_TEMPLATE : String = "res://Assets/Files/Dialogues/$file.json"

## SCENES --------------------------------------------
const START_MENU = "res://Assets/Scenes/StartMenu.tscn"
const ERROR = "res://Assets/Scenes/Error.tscn"
const LEVEL_1 = "res://Assets/Scenes/Level1.tscn"

## SCRIPT PATHS --------------------------------------
const CONTROLS_SCRIPT_PATH = "res://Assets/Scripts/Mechanics/Controls.gd"
const DIRECTION_SCRIPT_PATH = "res://Assets/Scripts/Mechanics/Direction.gd"
const TIME_SCRIPT_PATH = "res://Assets/Scripts/Shared/Time.gd"

## READ ONLY SCRIPTS ---------------------------------
const CONTROLS_SCRIPT = preload(CONTROLS_SCRIPT_PATH)
const DIRECTION_SCRIPT = preload(DIRECTION_SCRIPT_PATH)
const TIME_SCRIPT = preload(TIME_SCRIPT_PATH)
