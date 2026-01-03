class_name Interacctuable
extends StaticBody3D

signal interactuado
@export var mensaje = "Abrir puerta [E]"
@onready var animacion = $AnimationPlayer
var abrio = false
@export var permiso_para_entrar = false



func hacer_texto():
	if not abrio and not permiso_para_entrar:
		emit_signal("interactuado")
		animacion.play("abrir y cerrar")
		abrio = true
		mensaje = "Cerrar puerta [E]"
	elif abrio and not permiso_para_entrar:
		animacion.play_backwards("abrir y cerrar")
		abrio = false
		mensaje = "Abrir puerta [E]"
	return mensaje
