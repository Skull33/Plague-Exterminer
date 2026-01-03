class_name level_End
extends StaticBody3D

signal termino
@export var _termino_todas_las_hordas = false
@export var mensaje = " "

func finish_level():
	emit_signal("termino")
	if not _termino_todas_las_hordas:
		mensaje ="acabalos a todos primero"
	if _termino_todas_las_hordas:
		print("ganaste")
		get_tree().change_scene_to_file("res://final_nivel1.tscn")
	return mensaje
