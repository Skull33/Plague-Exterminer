class_name Interactuable_A
extends StaticBody3D

signal interactuado_1
@export var mensaje = "Abrir Puerta [E]"
@onready var animacion = $AnimationPlayer
@onready var audio = $"../../AudioStreamPlayer3D"
@onready var audio_2 = $"../../AudioStreamPlayer3D2"

var abrio = false
var llave = false
var es_azul = false
var interacted = false

func _ready() :
	add_to_group("Puertas_Azules")

func hacer_texto():
	emit_signal("interactuado_1")
	if not llave and not interacted:
		audio.play()
		mensaje = "Esta puerte requiere una llave [color=blue]AZUL[/color]"
		await (get_tree().create_timer(2).timeout)
		interacted = true
	if interacted:
		mensaje = "Abrir Puerta [E]"
		interacted = false

	if not abrio and llave:
		animacion.play("abrir")
		audio_2.play()
		abrio = true
		mensaje = "Cerrar puerta [E]"
	elif abrio and llave and es_azul:
		animacion.play_backwards("abrir")
		abrio = false
		mensaje = "Abrir puerta [E]"
	return mensaje
