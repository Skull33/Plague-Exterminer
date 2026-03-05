extends StaticBody3D

signal interactuado_1
@export var msg: String = ""
@export var mensaje: Label
@export var sonido : AudioStreamPlayer3D
@export var colision : CollisionShape3D
@export var item : Node3D
@export var tipo_arma: String
var interactuado = false
func _ready():
	mensaje.text = msg

func hacer_texto():
	emit_signal("interactuado_1")
	if Input.is_action_just_pressed("Interaccion"):
		var jugador = get_tree().get_first_node_in_group("jugador")
		
		if jugador:
			jugador.obtener_arma_tipo(tipo_arma)
		
		item.hide()
		sonido.play()
		colision.disabled = true
		msg = ""
		interactuado = true
	return msg
