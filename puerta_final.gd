class_name level_End
extends StaticBody3D

signal termino
@export var _termino_todas_las_hordas = false
@export var mensaje = "Abrir [E]"
var interacted = false

func finish_level():
	emit_signal("termino")
	if not _termino_todas_las_hordas and not interacted:
		mensaje ="[color=red]ACABALOS[/color] a todos primero"
		interacted = true
		await(get_tree().create_timer(2).timeout)
		mensaje = "Abrir [E]"
		interacted = false
	if _termino_todas_las_hordas:
		print("ganaste")
		get_tree().change_scene_to_file("res://final_nivel1.tscn")
	return mensaje
