class_name Interactuable_B
extends StaticBody3D

signal interactuado_1
@export var mensaje = "Abrir [E]"
@export var animacion : AnimationPlayer
@export var sonido_abrir : AudioStreamPlayer3D

var abrio = false

func hacer_texto():
	emit_signal("interactuado_1")
	if not abrio:
		animacion.play("abrir")
		sonido_abrir.play()
		abrio = true
		mensaje = "Cerrar [E]"
	elif abrio:
		animacion.play_backwards("abrir")
		abrio = false
		mensaje = "Abrir [E]"
	return mensaje
