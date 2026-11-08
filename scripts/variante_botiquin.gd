extends StaticBody3D

@export var puntos_de_salud = 0
@onready var jugador = get_tree().get_first_node_in_group("jugador")
@onready var area = $Area3D
@onready var audio = $AudioStreamPlayer3D
@onready var botiquin = $".."
var necesita_salud = false

func _ready():
	area.body_entered.connect(entro)

func entro(cuerpo):
	if jugador.cantidad_salud >= 100:
		necesita_salud = false
	if jugador.cantidad_salud < 100:
		necesita_salud = true
	if necesita_salud:
		if cuerpo is EsJugador:
			jugador._curar(puntos_de_salud)
			print("Tome Brutafen")
			botiquin.hide()
			audio.play()
			await(audio.finished)
			queue_free()
