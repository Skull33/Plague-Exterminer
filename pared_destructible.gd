class_name Destruir
extends StaticBody3D

signal SOY_destructible
@export var particulas: GPUParticles3D
@export var audio: AudioStreamPlayer3D
@export var colision: CollisionShape3D
@export var muro : MeshInstance3D
var mensaje = "Analizar muro"

func _destruccion():
	emit_signal("SOY_destructible")
	audio.play()
	muro.visible = false
	colision.disabled = true
	particulas.restart()
	await(get_tree().create_timer(particulas.lifetime).timeout)
	queue_free()

func _interaccion_sin_destruir():
	emit_signal("SOY_destructible")
	Dialogic.start("dialogo destruccion")
	return mensaje
