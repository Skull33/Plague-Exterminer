class_name Interactuable_A
extends StaticBody3D

signal interactuado_1
@export var mensaje = "Abrir Puerta [E]"
@onready var animacion = $AnimationPlayer

var abrio = false
var llave = false
var es_azul = false
var interacted = false

func _ready() :
	add_to_group("Puertas_Azules")

func hacer_texto():
	emit_signal("interactuado_1")
	if not llave and not interacted:
		mensaje = "Esta puerte requiere una llave AZUL"
		await (get_tree().create_timer(2).timeout)
		interacted = true
	if interacted:
		mensaje = "Abrir Puerta [E]"
		interacted = false

	if not abrio and llave:
		animacion.play("abrir")
		abrio = true
		mensaje = "Cerrar puerta [E]"
	elif abrio and llave and es_azul:
		animacion.play_backwards("abrir")
		abrio = false
		mensaje = "Abrir puerta [E]"
	return mensaje
