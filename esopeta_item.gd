class_name Escopeta_Item
extends StaticBody3D

signal interactuado_1
@export var mensaje = "Agarrar Escopeta [E]"
@onready var sonido = $AudioStreamPlayer3D
@onready var colision = $CollisionShape3D
@onready var item = $".."
var interactuado = false
@onready var doble_cañon = get_tree().get_first_node_in_group("jugador")

func hacer_texto():
	emit_signal("interactuado_1")
	if Input.is_action_just_pressed("Interaccion"):
		item.hide()
		sonido.play()
		colision.disabled = true
		mensaje = ""
		if doble_cañon is CharacterBody3D:
			doble_cañon.obtener_arma()
		interactuado = true
	return mensaje
