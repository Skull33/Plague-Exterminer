class_name Es_curativo
extends StaticBody3D

@export var puntos_de_salud = 0
@onready var jugador = get_tree().get_first_node_in_group("jugador")
@export var mensaje = "Tomar Pastillas"
var interaccion = false
signal Curacion
@onready var botiquin = $".."
@onready var colision = $CollisionShape3D
@onready var audio = $AudioStreamPlayer3D

var puede_curarse = false

func Aumentar_salud():
	if jugador.cantidad_salud >= 100:
		puede_curarse = false
		mensaje = "No las necesito"
		interaccion = true
	if jugador.cantidad_salud < 100:
		puede_curarse = true
		mensaje = "Tomar Pastillas"
		interaccion = false
	if not interaccion:
		emit_signal("Curacion")
		jugador._curar(puntos_de_salud)
		print("Tome Brutafen")
		mensaje = ""
		botiquin.hide()
		colision.disabled = true
		audio.play()
		interaccion = true
		await(audio.finished)
		queue_free()
	return mensaje 
