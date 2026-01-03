class_name Dialogar
extends StaticBody3D

signal dialogo

var dialogo_1 = false
var esta_cerca = false

@export var mensaje = "Hablar"

func Dialogos():
	if dialogo_1 == false:
		emit_signal("dialogo")
		if esta_cerca and not dialogo_1:
			dialogo_1 = true
			mensaje = ""
			Dialogic.start("dialgos_1")
	return mensaje
