extends Node3D

@onready var menu = $Menu/AnimationPlayer
@onready var boton_inicio = $Control/Button
@onready var boton_salir = $Control/Button2
@onready var logo = $Control/TextureRect
@onready var sonido_inicio = $AudioStreamPlayer3D
@onready var sonido_menu = $menu_mostrar
@onready var texto_enter = $Control/TextEdit
@onready var animaciones = $AnimationPlayer

func _ready():
	menu.play("escena")
	logo.visible = false
	boton_inicio.disabled = true
	boton_inicio.visible = false
	boton_salir.disabled = true
	boton_salir.visible = false
	texto_enter.visible = true
	animaciones.play("press enter")
	boton_inicio.pressed.connect(iniciar_juego)
	boton_salir.pressed.connect(terminar_juego)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(delta):
	if Input.is_action_just_pressed("Iniciar_menu"):
		sonido_menu.play()
		logo.visible = true
		boton_inicio.disabled = false
		boton_inicio.visible = true
		boton_salir.disabled = false
		boton_salir.visible = true
		texto_enter.visible = false
		animaciones.pause()
	elif Input.is_action_just_pressed("salir_De_menu"):
		logo.visible = false
		boton_inicio.disabled = true
		boton_inicio.visible = false
		boton_salir.disabled = true
		boton_salir.visible = false
		texto_enter.visible = true
		animaciones.play("press enter")

func iniciar_juego():
	sonido_inicio.play()
	await(sonido_inicio.finished)
	get_tree().change_scene_to_file("res://mensaje inicio.tscn")

func terminar_juego():
	get_tree().quit()
