extends Node3D

@onready var area = $Area3D
@onready var sprite = $Sprite3D
@onready var audio = $AudioStreamPlayer3D
@onready var colision = $Area3D/CollisionShape3D
@export var añadir_municion = 6
var activado = false

func _ready():
	await get_tree().process_frame
	activado = true
	area.body_entered.connect(entro)

func entro(cuerpo):
	if not activado:
		return
	if cuerpo is EsJugador:
		var escopeta = cuerpo.escopeta
		if not cuerpo.tiene_la_escopeta:
			escopeta.municion_actual = clamp(escopeta.municion_actual + añadir_municion,0,escopeta.municion_maxima)
		else:
			if escopeta.municion_actual == escopeta.municion_maxima:
				return
			escopeta.municion_actual = clamp(escopeta.municion_actual + añadir_municion,0,escopeta.municion_maxima)
			cuerpo.UI_arma()
	colision.disabled = true
	sprite.visible = false
	audio.play()
	await(audio.finished)
	queue_free()
