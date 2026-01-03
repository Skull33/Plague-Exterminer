extends Node3D

signal Aumentar_ammo
@onready var area = $Area3D
@onready var sprite = $Sprite3D
@onready var audio = $AudioStreamPlayer3D
@onready var colision = $Area3D/CollisionShape3D
@export var añadir_municion = 6
var puede_coger_municion = true

func _ready():
	area.body_entered.connect(entro)

func entro(cuerpo):
	for jugador in get_tree().get_nodes_in_group("jugador"):
		if jugador.municion_actual == jugador.municion_maxima:
			puede_coger_municion = false
	if cuerpo is EsJugador and puede_coger_municion:
		emit_signal("Aumentar_ammo")
		sprite.visible = false
		audio.play()
		colision.disabled = true
		await(audio.finished)
		queue_free()
		for jugador in get_tree().get_nodes_in_group("jugador"):
			jugador.municion_actual += añadir_municion
