extends Control

@onready var continuar = $Button
@onready var salir_al_menu = $Button2

func _ready() -> void:
	self.visible = false
	continuar.pressed.connect(despausar)
	salir_al_menu.pressed.connect(menu)

func _input(event):
	if event.is_action_pressed("Pausa"):
		get_tree().paused = not get_tree().paused
		self.visible = get_tree().paused
		
		if self.visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func despausar():
	get_tree().paused = not get_tree().paused
	self.visible = get_tree().paused
	
	if self.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func menu():
	get_tree().paused = not get_tree().paused
	get_tree().change_scene_to_file("res://escena_menu.tscn")
