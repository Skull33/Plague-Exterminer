class_name Interactuable_A
extends StaticBody3D

signal interactuado_1
@export var mensaje = "Abrir Puerta [E]"
@onready var animacion = $AnimationPlayer

var abrio = false
var llave = false
var es_azul = false

func _ready() :
	add_to_group("Puertas_Azules")

func hacer_texto():
	emit_signal("interactuado_1")
	if not llave:
		Dialogic.start("blocked_door")

	if not abrio and llave:
		animacion.play("abrir")
		abrio = true
		mensaje = "Cerrar puerta [E]"
	elif abrio and llave and es_azul:
		animacion.play_backwards("abrir")
		abrio = false
		mensaje = "Abrir puerta [E]"
	return mensaje
